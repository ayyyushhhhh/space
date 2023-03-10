import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/App%20State/app_state_provider.dart';

const Color kPrimaryColor = Color(0xFF724CF9);
const Color kSecondaryColor = Color(0xFFD2C6FF);
const Color kPrimaryTextColor = Color(0xFF45413C);
const Color kSecondaryTextColor = Color(0xFF8E8E8E);
const Color kLightModeTextFieldColor = Color(0xFFF2F2FA);
const Color kDarkModeScaffoldColor = Color(0xff223254);
const Color kDarkModeCardColor = Color(0xFF294261);
const Color kLightModeScaffoldColor = Colors.white;
const Color kLightModeCardColor = Color(0xFFF2F2FA);
const Color kDarkModeTextFieldColor = Color(0xFF3C3C56);
const Color kLightModeBottomNavBarColor = Color(0xFFF2F2FA);
const Color kDarkModeBottomNavBarColor = Color(0xFF3C3C56);
Color? getColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeScaffoldColor;
  }
  return kLightModeScaffoldColor;
}

Color? getBottomNavBarColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeBottomNavBarColor;
  }
  return kLightModeBottomNavBarColor;
}

Color? getTextColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return Colors.white;
  }
  return kPrimaryTextColor;
}

Color? getTextFieldColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeTextFieldColor;
  }
  return kLightModeTextFieldColor;
}

Brightness getSystemNavBarBrightness(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return Brightness.light;
  }
  return Brightness.dark;
}
