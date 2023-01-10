import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/screens/account_screen.dart';

import 'package:space/screens/journal/journals_screen.dart';
import 'package:space/utils/theme/app_state_provider.dart';

import 'journal/add_journal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final PageController controller = PageController();
  // final int _currentIndex = 0;
  final List<Widget> _screens = [
    const JournalsScreen(),
    const AccountScreen(),
  ];

  // Widget _buildBottomAppBarButton(
  //     {required IconData iconData,
  //     required String label,
  //     required int index,
  //     required VoidCallback callback}) {
  //   return MaterialButton(
  //     onPressed: callback,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Icon(
  //           iconData,
  //           size: 20.r,
  //         ),
  //         Text(
  //           label,
  //           style: TextStyle(fontSize: 20.sp),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const AddJournalScreen();
                }));
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomAppBar(
              notchMargin: 5,
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        value.updatePage(0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_add,
                            size: 20.r,
                            color: (value.pageState == 0)
                                ? Colors.blue
                                : Colors.white,
                          ),
                          Text(
                            "Journal",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: (value.pageState == 0)
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        value.updatePage(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            size: 24.r,
                            color: (value.pageState == 1)
                                ? Colors.blue
                                : Colors.white,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: (value.pageState == 1)
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     value.updatePage(0);
                    //   },
                    //   icon: const Icon(Icons.note),
                    // ),
                    // IconButton(
                    //   onPressed: () {
                    //     value.updatePage(1);
                    //   },
                    //   icon: const Icon(Icons.settings),
                    // )
                  ],
                ),
              ),
            ),
            body: _screens[value.pageState]);
      },
    );
  }
}

// BottomNavigationBar(
//             currentIndex: value.pageState,
//             selectedItemColor: Colors.blueAccent,
//             onTap: (index) {
//               value.updatePage(index);
//               controller.jumpToPage(index);
//             },
//             items: const [
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.note),
              //   label: "Journal",
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: "Settings",
              // ),
//             ],
//           ),