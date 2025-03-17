import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/onboarding_model.dart';

class OnboardingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitOnboarding(String uid, OnboardingModel onboardModel) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'onboarding_data': onboardModel.toMap(),
        'onboardingCompleted': true,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to submit onboarding: $e');
    }
  }

  Future<bool> hasCompletedOnboarding(String uid) async {
    DocumentSnapshot snapshot = await _firestore.doc('users/$uid').get();
    return snapshot.exists && (snapshot.get('onboardingCompleted') ?? false);
  }
}