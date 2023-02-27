import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/journal/view_journal_screen.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/helper/blur.dart';
import 'package:space/widgets/journal/mood_select_widget.dart';
import 'package:space/widgets/journal/note_text_field_widget.dart';
import 'package:space/widgets/journal/title_text_field_widget.dart';

class AddJournalPageWidget extends StatefulWidget {
  const AddJournalPageWidget({super.key});

  @override
  State<AddJournalPageWidget> createState() => _AddJournalPageWidgetState();
}

class _AddJournalPageWidgetState extends State<AddJournalPageWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();
  late JournalModel _journalModel;
  final List<Widget> _journalPages = [];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _journalPages.add(const MoodSelectWidget());
    _journalPages.add(
      TitleTextFieldWidget(textEditingController: _titleEditingController),
    );
    _journalPages.add(
      NotesTextFieldWidget(textEditingController: _notesEditingController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        _index = value.index;

        return WillPopScope(
          onWillPop: () async {
            if (_index == 0) {
              Navigator.pop(context);
              return false;
            }
            _index -= 1;
            value.updateIndex(_index);
            return false;
          },
          child: Scaffold(
              body: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            children: [
              Blur(
                blur: 10,
                blurColor: Colors.white,
                child: Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/illustrations/bg.svg",
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (_index <= 2)
                PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child,
                      Animation<double> primaryAnimation,
                      Animation<double> secondaryAnimation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(1.5, 0.0),
                      ).animate(secondaryAnimation),
                      child: FadeTransition(
                        opacity: Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(primaryAnimation),
                        child: child,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _journalPages[_index],
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (value.index == 2) {
                              _journalModel = _createJournal(context);
                            }
                            if (_index == 1 &&
                                _titleEditingController.text == "") {
                              return;
                            }
                            if (_index == 2 &&
                                _notesEditingController.text == "") {
                              return;
                            }
                            _index += 1;

                            value.updateIndex(_index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (_index == 3)
                ViewJournalScreen(
                  journalModel: _journalModel,
                  readOnly: false,
                ),
            ],
          )),
        );
      },
    );
  }

  JournalModel _createJournal(BuildContext context) {
    return JournalModel(
        journalId: (Random.secure().nextInt(90000) + 10000),
        createdOn: DateTime.now(),
        mood: Provider.of<JournalEditorProvider>(context, listen: false).mood,
        title: _titleEditingController.text,
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        description: _notesEditingController.text);
  }
}
