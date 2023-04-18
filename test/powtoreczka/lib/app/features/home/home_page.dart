import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:powtoreczka/app/features/home/add_opinion/add_opinion_page.dart';
import 'package:powtoreczka/app/features/home/my_account/my_account_page.dart';
import 'package:powtoreczka/app/features/home/restaurants/restaurants_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Najlepsza pizza'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return (OpinionPage());
        }
        if (currentIndex == 2) {
          return (AddingPage(
            onSave: () {
              setState(() {
                currentIndex = 0;
              });
            },
          ));
        }

        return MyAccount(email: widget.user.email);
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
            icon: Icon(Icons.reviews),
            label: 'Opinie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spoke),
            label: 'All',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
