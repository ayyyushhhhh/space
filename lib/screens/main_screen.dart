import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/screens/account_screen.dart';
import 'package:space/screens/journal/add_journal_screen.dart';
import 'package:space/screens/journal/journals_screen.dart';
import 'package:space/utils/App%20State/app_state_provider.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/Bottom%20Nav%20Bar/bottom_nar_bar.dart';
import 'package:space/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';

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
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: OpenContainer(
              closedColor: kPrimaryColor,
              closedShape: const CircleBorder(),
              closedElevation: 0,
              // closedShape: const CircleBorder(),
              transitionType: ContainerTransitionType.fadeThrough,
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return SizedBox(
                  width: 70.h,
                  height: 70.h,
                  child: RawMaterialButton(
                    fillColor: kPrimaryColor,
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    onPressed: openContainer,
                    child: Icon(
                      Icons.add,
                      size: 50.sp,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              openBuilder: (BuildContext _, VoidCallback __) {
                return const AddJournalPageWidget();
              }),
          extendBody: true,
          body: PageTransitionSwitcher(
              reverse: true,
              duration: const Duration(milliseconds: 500),
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
            items: [
              BottomNavBarWidget(
                iconData: CupertinoIcons.layers,
                iconSize: 20.r,
                label: 'Journals',
              ),
              BottomNavBarWidget(
                iconData: Icons.settings,
                iconSize: 20.r,
                label: 'Settings',
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
