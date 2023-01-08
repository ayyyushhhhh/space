import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journalProvider.dart';
import 'package:space/screens/journal/add_journal_screen.dart';

class JournalsScreen extends StatelessWidget {
  const JournalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const AddJournalScreen();
            }));
          },
          child: const Icon(Icons.radio_button_checked),
        ),
        body: Column(
          children: [
            const Text("NoteBooks"),
            Consumer<JournalProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.journalsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String title =
                        value.journalsList[index].createdOn.toString();
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return AddJournalScreen(
                            journalModel: value.journalsList[index],
                          );
                        }));
                      },
                      child: ListTile(
                        title: Text(title),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
