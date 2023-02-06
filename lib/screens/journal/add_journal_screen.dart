import 'package:easy_localization/easy_localization.dart';
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

class _AddJournalPageWidgetState extends State<AddJournalPageWidget> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController notesEditingController = TextEditingController();
  List<Widget> journalPages = [
    const MoodSelectWidget(),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    journalPages.add(
      TitleTextFieldWidget(textEditingController: titleEditingController),
    );
    journalPages.add(
      NotesTextFieldWidget(textEditingController: notesEditingController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      children: [
        Blur(
          blur: 2,
          blurColor: Colors.white,
          child: Positioned.fill(
            child: SvgPicture.asset(
              "assets/illustrations/bg.svg",
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              journalPages[index],
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  if (index == 2) {
                    JournalModel journalModel = JournalModel(
                        journalId: 23455,
                        createdOn: DateTime.now(),
                        mood: Provider.of<JournalEditorProvider>(context,
                                listen: false)
                            .mood,
                        title: titleEditingController.text,
                        color: Colors.red,
                        description: notesEditingController.text);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ViewJournalScreen(
                        journalModel: journalModel,
                      );
                    }));
                  }
                  setState(() {
                    if (index < journalPages.length - 1) {
                      index += 1;
                    }
                  });
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
                      index == 2 ? "Continue" : "Next",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
