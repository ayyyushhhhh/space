// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MoodType { happy, sad, angry, neutral, worried }

class JournalModel {
  int journalId;
  DateTime createdOn;
  String mood;
  Color? color;
  List<dynamic> journalData;

  JournalModel({
    required this.journalId,
    required this.createdOn,
    required this.mood,
    this.color,
    required this.journalData,
  });

  JournalModel copyWith({
    int? journalId,
    DateTime? createdOn,
    String? mood,
    Color? color,
    List<dynamic>? journalData,
  }) {
    return JournalModel(
      journalId: journalId ?? this.journalId,
      createdOn: createdOn ?? this.createdOn,
      mood: mood ?? this.mood,
      color: color ?? this.color,
      journalData: journalData ?? this.journalData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'journalId': journalId,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'mood': mood,
      'color': color?.value,
      'journalData': journalData,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
        journalId: map['journalId'] as int,
        createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int),
        mood: map['mood'] as String,
        color: map['color'] != null ? Color(map['color'] as int) : null,
        journalData: List<dynamic>.from(
          (map['journalData'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory JournalModel.fromJson(String source) =>
      JournalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JournalModel(journalId: $journalId, createdOn: $createdOn, mood: $mood, color: $color, journalData: $journalData)';
  }

  @override
  bool operator ==(covariant JournalModel other) {
    if (identical(this, other)) return true;

    return other.journalId == journalId &&
        other.createdOn == createdOn &&
        other.mood == mood &&
        other.color == color &&
        listEquals(other.journalData, journalData);
  }

  @override
  int get hashCode {
    return journalId.hashCode ^
        createdOn.hashCode ^
        mood.hashCode ^
        color.hashCode ^
        journalData.hashCode;
  }
}
