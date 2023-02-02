import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddJournalPageWidget extends StatefulWidget {
  const AddJournalPageWidget({super.key});

  @override
  State<AddJournalPageWidget> createState() => _AddJournalPageWidgetState();
}

class _AddJournalPageWidgetState extends State<AddJournalPageWidget> {
  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  Future<void> loadAsset() async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final images = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/emojis'));
    print(images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/emojis/amazed.svg",
                      height: 60.h,
                      width: 60.w,
                    ),
                    SvgPicture.asset(
                      "assets/emojis/amazed.svg",
                      height: 60.h,
                      width: 60.w,
                    ),
                    SvgPicture.asset(
                      "assets/emojis/amazed.svg",
                      height: 60.h,
                      width: 60.w,
                    ),
                    SvgPicture.asset(
                      "assets/emojis/amazed.svg",
                      height: 60.h,
                      width: 60.w,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
