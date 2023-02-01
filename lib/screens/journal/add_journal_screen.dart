import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/widgets/journal/journal_icon_button.dart';

import 'package:space/widgets/journal/note_text_field_widget.dart';
import 'package:space/widgets/journal/title_text_field_widget.dart';

class AddJournalScreen extends StatefulWidget {
  final JournalModel? journalModel;

  const AddJournalScreen({super.key, this.journalModel});

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  late DateTime createdOn;

  late String moodNow;
  late Color journalColor;
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _notesTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    initJournalModel();
  }

  void initJournalModel() {
    if (widget.journalModel == null) {
      final time = Provider.of<JournalProvider>(context, listen: false).getDate;
      createdOn = DateTime(
          time.year,
          time.month,
          time.day,
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second,
          time.millisecond,
          time.microsecond);
      moodNow = "happy";
      Provider.of<JournalEditorProvider>(context, listen: false).readOnly =
          false;
    } else {
      createdOn = widget.journalModel!.createdOn;
      moodNow = widget.journalModel!.mood;
      _notesTextEditingController.text = widget.journalModel!.description;
      _titleTextEditingController.text = widget.journalModel!.title;
      Provider.of<JournalEditorProvider>(context, listen: false).readOnly =
          true;
      Provider.of<JournalEditorProvider>(context, listen: false).mood = moodNow;
    }
  }

  @override
  void dispose() {
    _notesTextEditingController.dispose();
    _titleTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Semantics(
                          label: 'Go Back',
                          hint: 'Press to go back',
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              CupertinoIcons.clear_thick,
                              size: 50.r,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 10.w,
                        ),
                        Semantics(
                          label: 'Edit Journal',
                          hint: 'Press to edit journal',
                          child: Consumer<JournalEditorProvider>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              if (value.readOnly == true) {
                                return JournalIconButton(
                                  onPressed: () {
                                    value.canReadOnly(false);
                                  },
                                  iconData: CupertinoIcons.pen,
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        Semantics(
                          label: 'Save Journal',
                          hint: 'Press to save journal',
                          child: JournalIconButton(
                            onPressed: () {
                              _saveJournal();
                              Navigator.pop(context);
                            },
                            iconData: CupertinoIcons.check_mark,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('EEEE', context.locale.toString())
                          .format(createdOn),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                      ),
                    ).tr(),
                    Text(
                      DateFormat('d, MMMM, yyyy', context.locale.toString())
                          .format(createdOn),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              Semantics(
                label: 'Enter Title not more than 40 letters',
                hint: 'Press to enter journal title',
                child: TitleTextFieldWidget(
                  textEditingController: _titleTextEditingController,
                ),
              ),
              NotesTextFieldWidget(
                  textEditingController: _notesTextEditingController),
              Container(
                height: 50.h,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                color: Theme.of(context).cardColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Mood",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    _buildEmoji(emoji: "😀", mood: 'happy'),
                    _buildEmoji(emoji: "😞", mood: 'sad'),
                    _buildEmoji(emoji: "😐", mood: 'confused'),
                    _buildEmoji(emoji: "😤", mood: 'angry'),
                    _buildEmoji(emoji: "😨", mood: 'worried'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveJournal() async {
    if (_titleTextEditingController.text == "" ||
        _notesTextEditingController.text == "") {
      return;
    }
    late JournalModel journalModel;
    if (widget.journalModel == null) {
      final journalId = (Random.secure().nextInt(90000) + 10000);
      journalModel = JournalModel(
        journalId: journalId,
        createdOn: createdOn,
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        mood: Provider.of<JournalEditorProvider>(context, listen: false).mood,
        description: _notesTextEditingController.text,
        title: _titleTextEditingController.text,
      );
    } else {
      journalModel = widget.journalModel!.copyWith(
        title: _titleTextEditingController.text,
        description: _notesTextEditingController.text,
        mood: Provider.of<JournalEditorProvider>(context, listen: false).mood,
      );
    }

    Provider.of<JournalProvider>(context, listen: false)
        .updateJournalList(journalModel);
  }

  Widget _buildEmoji({required String emoji, required String mood}) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        double svgSize = 40.sp;
        if (mood == value.mood) {
          svgSize = 50.sp;
        }
        return Semantics(
          label: '$mood Mood',
          hint: 'Press to enter $mood Mood',
          child: InkWell(
            onTap: () {
              if (value.readOnly == false) {
                mood = mood;
                value.changeMood(mood);
              }
            },
            child: SvgPicture.asset(
              "assets/emojis/$mood.svg",
              height: svgSize,
              width: svgSize,
            ),
          ),
        );
      },
    );
  }
}
