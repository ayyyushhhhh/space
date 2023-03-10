import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/blur.dart';
import 'package:space/screens/Journals/View%20Journal%20Screen/view_journal_screen.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/mood_select_widget.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/note_text_field_widget.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/title_text_field_widget.dart';

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
  final List<Widget> _journalPages = [const MoodSelectWidget()];
  int _index = 0;

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
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _journalPages[value.index],
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
                          } else {
                            _journalPages.add(
                              TitleTextFieldWidget(
                                  textEditingController:
                                      _titleEditingController),
                            );
                          }
                          if (_index == 2 &&
                              _notesEditingController.text == "") {
                            return;
                          } else {
                            _journalPages.add(
                              NotesTextFieldWidget(
                                  textEditingController:
                                      _notesEditingController),
                            );
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
