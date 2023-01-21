import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/my_account/my_account_page_content.dart';
import 'package:lifediary_project/app/home/to_do_list/to_do_list_content.dart';
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
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return Center(
            child: Text('2'),
          );
        }
        if (currentIndex == 2) {
          return Center(
            child: Text('3'),
          );
        }
        if (currentIndex == 3) {
          return Center(
            child: Text('4'),
          );
        }
        if (currentIndex == 4) {
          return ToDoListContent();
        }
        if (currentIndex == 5) {
          return Center(
            child: Text('6'),
          );
        }
        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
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
