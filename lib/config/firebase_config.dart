import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  debugPrint('🔥 Initializing Firebase...');
  try {
    await Firebase.initializeApp();
    debugPrint('✅ Firebase initialization successful');
  } catch (e) {
    debugPrint('❌ Firebase initialization failed: $e');
    rethrow;
  }
}