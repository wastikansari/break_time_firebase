import 'package:cloud_firestore/cloud_firestore.dart';

class BreakModel {
  final String startTime;
  final int duration; // Duration in seconds
  final bool endedEarly;
  final Timestamp? endTime;

  BreakModel({
    required this.startTime,
    required this.duration,
    this.endedEarly = false,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'duration': duration,
      'endedEarly': endedEarly,
      'endTime': endTime,
    };
  }

  factory BreakModel.fromMap(Map<String, dynamic> map) {
    return BreakModel(
      startTime: map['startTime'],
      duration: map['duration'],
      endedEarly: map['endedEarly'] ?? false,
      endTime: map['endTime'],
    );
  }
}