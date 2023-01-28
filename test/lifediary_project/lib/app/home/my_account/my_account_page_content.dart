import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/to_do_list/to_do_list_content.dart';
import 'package:lifediary_project/app/login/login_page.dart';
import 'package:lifediary_project/app/login/user_profile.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  LoginPage moveToLogin() {
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Zalogowano jako $email! '),
          const SizedBox(height: 20),
          CircleAvatar(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                    
                  ),
                );
              },
              icon: const Icon(
                Icons.person,
                color: Colors.amber,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                //moveToLogin();
                //Navigator.of(context).pop();
                //Navigator.pushNamed(context, '/login');
              },
              child: const Text('Wyloguj')),
        ],
      ),
    );
  }
}
