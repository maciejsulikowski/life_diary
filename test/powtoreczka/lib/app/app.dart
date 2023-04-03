import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powtoreczka/app/cubit/root_cubit.dart';
import 'package:powtoreczka/app/features/home/home_page.dart';
import 'package:powtoreczka/app/features/login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          if (state.isLoading) {
            return CircularProgressIndicator();
          }
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                state.errorMessage,
              ),
            );
          }
          final user = state.user;

          if (user == null) {
            return LoginPage();
          }
          return HomePage(user: user);

          return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                if (user == null) {
                  return LoginPage();
                }
                return HomePage(user: user);
              });
        },
      ),
    );
  }
}
