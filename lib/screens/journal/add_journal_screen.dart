import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journalProvider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
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
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            CupertinoIcons.back,
                            size: 30.r,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 10,
                        ),
                        Consumer<JournalEditorProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (value.readOnly == true) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  value.canReadOnly(false);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 30.r,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _saveJournal();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.done,
                            size: 30.r,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('EEEE').format(createdOn),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                      ),
                    ),
                    Text(
                      DateFormat('d, MMMM, yyyy').format(createdOn),
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
              TitleTextFieldWidget(
                textEditingController: _titleTextEditingController,
              ),
              NotesTextFieldWidget(
                  textEditingController: _notesTextEditingController),
              Container(
                height: 50.h,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                    _buildEmoji(emoji: "😐", mood: 'neutral'),
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
    print(_notesTextEditingController.text);
    Provider.of<JournalProvider>(context, listen: false)
        .updateJournalList(journalModel);
  }

  Widget _buildEmoji({required String emoji, required String mood}) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        double fontSize = 20.sp;
        if (mood == value.mood) {
          fontSize = 30.sp;
        }
        return InkWell(
          onTap: () {
            if (value.readOnly == true) {
              mood = mood;
              value.changeMood(mood);
            }
          },
          child: Text(
            emoji,
            style: TextStyle(fontSize: fontSize),
          ),
        );
      },
    );
  }
}
