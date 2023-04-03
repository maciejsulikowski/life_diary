import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powtoreczka/app/cubit/root_cubit.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Jestes zalogowany jako: ${email}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<RootCubit>().signOut();
            },
            child: Text('Wyloguj sie'),
          ),
        ],
      ),
    );
  }
}
