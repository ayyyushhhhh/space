import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/screens/Home/home_screen.dart';
import 'package:space/screens/Journals/Account%20Screen/account_screen.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/add_journal_screen.dart';
import 'package:space/screens/Journals/Journals%20Screen/journals_screen.dart';
import 'package:space/provider/App%20State/app_state_provider.dart';
import 'package:space/screens/To%20Do%20Screen/to_do_screen.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nar_bar.dart';
import 'package:space/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ToDoScreen(),
    const JournalsScreen(),
    const AccountScreen(),
  ];

  Widget _buildFAB() {
    return SizedBox(
      width: 70.h,
      height: 70.h,
      child: RawMaterialButton(
        fillColor: kJournalSecondayColor,
        shape: const CircleBorder(),
        elevation: 0.0,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return const AddJournalPageWidget();
          }));
        },
        child: Icon(
          Icons.add,
          size: 50.sp,
          color: kCalendarPrimaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: value.pageState == 2 ? _buildFAB() : null,
          // floatingActionButton: OpenContainer(
          //   closedColor: kPrimaryColor,
          //   closedShape: const CircleBorder(),
          //   closedElevation: 0,
          //   // closedShape: const CircleBorder(),
          //   transitionType: ContainerTransitionType.fadeThrough,
          //   closedBuilder: (BuildContext _, VoidCallback openContainer) {
          //     return SizedBox(
          //       width: 70.h,
          //       height: 70.h,
          //       child: RawMaterialButton(
          //         fillColor: kPrimaryColor,
          //         shape: const CircleBorder(),
          //         elevation: 0.0,
          //         onPressed: openContainer,
          //         child: Icon(
          //           Icons.add,
          //           size: 50.sp,
          //           color: Colors.white,
          //         ),
          //       ),
          //     );
          //   },
          //   openBuilder: (BuildContext _, VoidCallback __) {
          //     return const AddJournalPageWidget();
          //   },
          // ),
          extendBody: true,
          body: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  fillColor: Colors.transparent,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: _screens[value.pageState]),
          bottomNavigationBar: BottomRoundedNavBar(
            height: 70,
            items: [
              BottomNavBarWidget(
                iconData: Icons.home,
                iconSize: 30.r,
                selectedIconColor: kHomePrimaryColor,
              ),
              BottomNavBarWidget(
                iconData: Icons.list_alt,
                iconSize: 30.r,
                selectedIconColor: kTodoPrimaryColor,
              ),
              BottomNavBarWidget(
                iconData: Icons.library_books,
                iconSize: 30.r,
                selectedIconColor: kJournalPrimaryColor,
              ),
              BottomNavBarWidget(
                iconData: Icons.person,
                iconSize: 30.r,
                selectedIconColor: kAccountPrimaryColor,
              ),
            ],
            currentIndex: value.pageState,
            onChanged: (int index) {
              value.updatePage(index);
            },
          ),
        );
      },
    );
  }
}
