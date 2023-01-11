import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:space/hive%20boxes/journal_box.dart';
import 'package:space/provider/journal/journalProvider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/main_screen.dart';
import 'package:space/utils/pref.dart';
import 'package:space/utils/theme/app_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await SharedPreferencesHelper.init();
  Hive.init(dir.path);
  await JournalHiveBox.init(dateTime: DateTime.now());
  GoogleFonts.config.allowRuntimeFetching = false;
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
          ChangeNotifierProvider<JournalEditorProvider>(
            create: (BuildContext context) {
              return JournalEditorProvider();
            },
          ),
          ChangeNotifierProvider<AppStateProvider>(
            create: (BuildContext context) {
              return AppStateProvider();
            },
          ),
        ],
        child: Consumer<AppStateProvider>(
          builder: (BuildContext context, theme, Widget? child) {
            return ScreenUtilInit(
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Space',
                  darkTheme: ThemeData.dark().copyWith(
                    primaryColor: const Color(0xFF303030),
                    textTheme: GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme,
                    ),
                  ),
                  theme: ThemeData.light().copyWith(
                    primaryColor: const Color(0xFFFAFAFA),
                    textTheme: GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme,
                    ),
                  ),
                  themeMode:
                      theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  home: const MainScreen(),
                );
              },
            );
          },
        ));
  }
}
