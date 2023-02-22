import 'package:url_launcher/url_launcher.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

Future<void> openPlayStore() async {
  String playStoreLink =
      "https://play.google.com/store/apps/details?id=com.scarecrowhouse.space";

  final uri = Uri.parse(playStoreLink);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    return;
  }
}
