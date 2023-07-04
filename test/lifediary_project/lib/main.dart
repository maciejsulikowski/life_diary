import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'firebase_options.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
