import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

LoginPage moveToLogin() {
  return LoginPage();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Zalogowano!'),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  //moveToLogin();
                  //Navigator.of(context).pop();
                  // Navigator.pushNamed(context, '/login');
                },
                child: const Text('Wyloguj')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Konto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Dziennik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics_rounded),
            label: 'Trening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Woda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'To Do List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Plan dnia',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
