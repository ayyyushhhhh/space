import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journalProvider.dart';

class AddJournalScreen extends StatelessWidget {
  AddJournalScreen({super.key});
  final QuillController _quillController = QuillController.basic();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Provider.of<JournalProvider>(context, listen: false).addJournal(
              JournalModel(
                createdOn: DateTime.now(),
                mood: "mood",
                journalData: _quillController.document.toDelta().toJson(),
              ),
            );
          },
        ),
        body: Column(
          children: [
            QuillToolbar.basic(controller: _quillController),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: QuillEditor(
                  controller: _quillController,
                  readOnly: false,
                  autoFocus: true,
                  expands: true,
                  focusNode: FocusNode(),
                  padding: const EdgeInsets.all(8.0),
                  scrollController: _scrollController,
                  scrollable: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
