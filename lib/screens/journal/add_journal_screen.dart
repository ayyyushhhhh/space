import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journalProvider.dart';
import 'package:space/provider/journal/mood_provider.dart';

class AddJournalScreen extends StatefulWidget {
  final JournalModel? journalModel;

  const AddJournalScreen({super.key, this.journalModel});

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  late quill.QuillController _quillController;
  late DateTime createdOn;
  final ScrollController _scrollController = ScrollController();
  late String moodNow;

  @override
  void initState() {
    super.initState();
    if (widget.journalModel == null) {
      _quillController = quill.QuillController.basic();
      createdOn = DateTime.now();
      moodNow = "happy";
    } else {
      _quillController = quill.QuillController.basic();
      createdOn = widget.journalModel!.createdOn;
      _quillController.document =
          quill.Document.fromJson(widget.journalModel!.journalData);
      moodNow = widget.journalModel!.mood;
    }
  }

  @override
  void dispose() {
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (widget.journalModel == null) {
                          final journalId =
                              (Random.secure().nextInt(90000) + 10000);
                          Provider.of<JournalProvider>(context, listen: false)
                              .addJournal(
                            JournalModel(
                              createdOn: createdOn,
                              mood: moodNow,
                              journalData:
                                  _quillController.document.toDelta().toJson(),
                              journalId: journalId,
                            ),
                          );
                        } else {
                          Provider.of<JournalProvider>(context, listen: false)
                              .addJournal(
                            widget.journalModel!.copyWith(
                              journalData:
                                  _quillController.document.toDelta().toJson(),
                            ),
                          );
                        }

                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.back,
                        size: 50.r,
                        color: Colors.white,
                      ),
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
                    quill.QuillToolbar.basic(
                      controller: _quillController,
                      dialogTheme: quill.QuillDialogTheme(
                        dialogBackgroundColor: Colors.black,
                      ),
                      iconTheme: const quill.QuillIconTheme(
                          iconSelectedColor: Colors.purpleAccent,
                          iconSelectedFillColor: Colors.transparent),
                      toolbarIconSize: 20.sp,
                      showFontFamily: false,
                      showFontSize: false,
                      showListBullets: true,
                      showCodeBlock: false,
                      showBoldButton: true,
                      showItalicButton: true,
                      showUnderLineButton: true,
                      showSearchButton: false,
                      showLink: false,
                      showListCheck: false,
                      showAlignmentButtons: false,
                      showInlineCode: false,
                      showDirection: false,
                      showJustifyAlignment: false,
                      showDividers: false,
                      showCenterAlignment: false,
                      showBackgroundColorButton: false,
                      showListNumbers: false,
                      showIndent: false,
                      showClearFormat: false,
                      showColorButton: false,
                      showLeftAlignment: false,
                      multiRowsDisplay: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: quill.QuillEditor(
                    controller: _quillController,
                    readOnly: false,
                    autoFocus: true,
                    expands: true,
                    focusNode: FocusNode(canRequestFocus: true),
                    padding: const EdgeInsets.all(8.0),
                    scrollController: _scrollController,
                    scrollable: true,
                  ),
                ),
              ),
              Container(
                height: 50.h,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                color: Colors.white,
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

  Widget _buildEmoji({required String emoji, required String mood}) {
    return Consumer<MoodProvider>(
      builder: (BuildContext context, value, Widget? child) {
        double fontSize = 20.sp;
        if (moodNow == value.mood) {
          fontSize = 30.sp;
        }
        return InkWell(
          onTap: () {
            moodNow = mood;
            value.changeMood(mood);
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
