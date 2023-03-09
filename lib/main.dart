import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:space/hive%20boxes/journal_box.dart';
import 'package:space/notification%20manager/notification_manager.dart';
import 'package:space/provider/User/points_provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/Main%20Screen/main_screen.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/utils/pref.dart';
import 'package:space/provider/App%20State/app_state_provider.dart';
import 'package:timezone/data/latest_10y.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  final dir = await getApplicationDocumentsDirectory();
  await SharedPreferencesHelper.init();
  Hive.init(dir.path);

  JournalHiveBox.init(dateTime: DateTime.now());

  NotificationManger.init();
  GoogleFonts.config.allowRuntimeFetching = false;
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        saveLocale: true,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
          ChangeNotifierProvider<PointsProvider>(
            create: (BuildContext context) {
              return PointsProvider();
            },
          ),
        ],
        child: Consumer<AppStateProvider>(
          builder: (BuildContext context, theme, Widget? child) {
            return ScreenUtilInit(
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  title: 'Space',
                  darkTheme: ThemeData.dark().copyWith(
                    primaryColor: kPrimaryColor,
                    canvasColor: Colors.transparent,
                    cardColor: kDarkModeCardColor,
                    scaffoldBackgroundColor: kDarkModeScaffoldColor,
                    textTheme: GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme,
                    ).apply(
                      bodyColor: Colors.white,
                      displayColor: Colors.white,
                    ),
                  ),
                  theme: ThemeData.light().copyWith(
                    primaryColor: kPrimaryColor,
                    scaffoldBackgroundColor: kLightModeScaffoldColor,
                    canvasColor: Colors.transparent,
                    cardColor: kLightModeCardColor,
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
