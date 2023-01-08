// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum MoodType { happy, sad, angry, neutral, worried }

class JournalModel {
  int journalId;
  DateTime createdOn;
  String mood;
  List<dynamic> journalData;

  JournalModel({
    required this.journalId,
    required this.createdOn,
    required this.mood,
    required this.journalData,
  });

  JournalModel copyWith({
    int? journalId,
    DateTime? createdOn,
    String? mood,
    List<dynamic>? journalData,
  }) {
    return JournalModel(
      journalId: journalId ?? this.journalId,
      createdOn: createdOn ?? this.createdOn,
      mood: mood ?? this.mood,
      journalData: journalData ?? this.journalData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'journalId': journalId,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'mood': mood,
      'journalData': journalData,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      journalId: map['journalId'] as int,
      createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int),
      mood: map['mood'] as String,
      journalData: List<dynamic>.from(
        (map['journalData'] as List<dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory JournalModel.fromJson(String source) =>
      JournalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JournalModel(journalId: $journalId, createdOn: $createdOn, mood: $mood, journalData: $journalData)';
  }

  @override
  bool operator ==(covariant JournalModel other) {
    if (identical(this, other)) return true;

    return other.journalId == journalId &&
        other.createdOn == createdOn &&
        other.mood == mood &&
        listEquals(other.journalData, journalData);
  }

  @override
  int get hashCode {
    return journalId.hashCode ^
        createdOn.hashCode ^
        mood.hashCode ^
        journalData.hashCode;
  }
}
