import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journalProvider.dart';
import 'package:space/screens/journal/journals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JournalProvider>(
          create: (BuildContext context) {
            return JournalProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Space',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const JournalsScreen(),
      ),
    );
  }
}
