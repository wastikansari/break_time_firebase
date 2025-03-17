import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/break_model.dart';

class BreakService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<BreakModel?> fetchBreakData(String uid) async {
  try {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('breaks')
        .orderBy('startTime', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return BreakModel.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      // Create a new break for the user
      String startTime = DateTime.now().toIso8601String();
      int duration = 300; // Default 5 minutes
      BreakModel newBreak = BreakModel(startTime: startTime, duration: duration);
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('breaks')
          .doc(startTime)
          .set(newBreak.toMap());
      return newBreak;
    }
  } catch (e) {
    throw Exception('Failed to fetch break data: $e');
  }
}

  Future<void> endBreakEarly(String uid, BreakModel breakData) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('breaks')
          .doc(breakData.startTime)
          .update({
        'endedEarly': true,
        'endTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to end break: $e');
    }
  }
}