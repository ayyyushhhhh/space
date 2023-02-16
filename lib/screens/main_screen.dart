import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/auth/local_auth/local_authentication.dart';
import 'package:space/screens/account_screen.dart';
import 'package:space/screens/journal/add_journal_screen.dart';
import 'package:space/screens/journal/journals_screen.dart';
import 'package:space/utils/App%20State/app_state_provider.dart';
import 'package:space/utils/constants.dart';
import 'package:space/utils/pref.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const JournalsScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.pink,
    ));
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            width: 70.h,
            height: 70.h,
            child: RawMaterialButton(
              fillColor: kPrimaryColor,
              shape: const CircleBorder(),
              elevation: 0.0,
              child: Icon(
                Icons.add,
                size: 50.sp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const AddJournalPageWidget();
                })).then((value) {
                  SystemChrome.setSystemUIOverlayStyle(
                    const SystemUiOverlayStyle(statusBarColor: kSecondaryColor),
                  );
                });
              },
            ),
          ),
          // bottomNavigationBar: Container(
          //   height: 70.h,
          //   padding: const EdgeInsets.all(5),
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       topRight: Radius.circular(20),
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       SizedBox(
          //         width: 20.w,
          //       ),
          //       _renderBottomNavBarWidget(
          //           iconData: Icons.notes,
          //           label: 'Journals',
          //           currentIndex: 0,
          //           selectedIndex: value.pageState),
          //     ],
          //   ),
          // ),

          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: getColorbyTheme(context),
              indicatorColor: kPrimaryColor,
            ),
            child: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              height: 60.h,
              elevation: 10,
              onDestinationSelected: (int index) {
                value.updatePage(index);
              },
              selectedIndex: value.pageState,
              destinations: const <Widget>[
                NavigationDestination(
                  icon: Icon(Icons.notes),
                  label: 'Journals',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
          body: _screens[value.pageState],
        );
      },
    );
  }

  void _authenticate() async {
    if (SharedPreferencesHelper.getAuthPermission() == true) {
      await LocalAuthApi.authenticate();
    }
  }

  Widget _renderBottomNavBarWidget(
      {required IconData iconData,
      required String label,
      required int currentIndex,
      required int selectedIndex}) {
    Color widgetColor =
        currentIndex == selectedIndex ? Colors.white : Colors.black;
    Color containercolor =
        currentIndex == selectedIndex ? kPrimaryColor : Colors.transparent;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                size: 20.r,
                color: widgetColor,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 14.sp, color: widgetColor),
              )
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
