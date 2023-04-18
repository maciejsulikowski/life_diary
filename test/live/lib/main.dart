import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live/app/app.dart';
import 'package:live/app/core/injection_container.dart';
import 'package:live/features/auth/auth_gate.dart';
import 'package:live/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
