import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';

class TitleTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const TitleTextFieldWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            readOnly: value.readOnly,
            controller: textEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              fillColor: Theme.of(context).cardColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: "Title",
            ),
            maxLength: 40,
          ),
        );
      },
    );
  }
}
