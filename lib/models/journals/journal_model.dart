// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum MoodType { happy, sad, angry, neutral, cheerful, worried }

class JournalModel {
  DateTime createdOn;
  String mood;
  List<dynamic> journalData;

  JournalModel({
    required this.createdOn,
    required this.mood,
    required this.journalData,
  });

  JournalModel copyWith({
    DateTime? onCreated,
    String? mood,
    List<dynamic>? journalData,
  }) {
    return JournalModel(
      createdOn: onCreated ?? createdOn,
      mood: mood ?? this.mood,
      journalData: journalData ?? this.journalData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'onCreated': createdOn.millisecondsSinceEpoch,
      'mood': mood,
      'journalData': journalData,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
        createdOn: DateTime.fromMillisecondsSinceEpoch(map['onCreated'] as int),
        mood: map['mood'] as String,
        journalData: List<dynamic>.from(
          (map['journalData'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory JournalModel.fromJson(String source) =>
      JournalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'JournalModel(onCreated: $createdOn, mood: $mood, journalData: $journalData)';

  @override
  bool operator ==(covariant JournalModel other) {
    if (identical(this, other)) return true;

    return other.createdOn == createdOn &&
        other.mood == mood &&
        listEquals(other.journalData, journalData);
  }

  @override
  int get hashCode => createdOn.hashCode ^ mood.hashCode ^ journalData.hashCode;
}
