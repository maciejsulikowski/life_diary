import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/daily_plan/daily_plan_page_content.dart';
import 'package:lifediary_project/app/features/diaries/diaries_page_content.dart';
import 'package:lifediary_project/app/features/my_account/my_account_page_content.dart';

import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/features/to_do_list/to_do_list_content.dart';
import 'package:lifediary_project/app/features/training/training_page_content.dart';
import 'package:lifediary_project/app/features/water/water_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
    
  }) : super(key: key);

  final User user;
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return MyAccountPageContent(
            email: widget.user.email,
            
          );
        }
        if (currentIndex == 1) {
          return DiariesPageContent();
        }
        if (currentIndex == 2) {
          return Center(
            child: TrainingPageContent(),
          );
        }
        if (currentIndex == 3) {
          return Center(
            child: WaterPage()
          );
        }
        if (currentIndex == 4) {
          return ToDoListContent();
        }
        if (currentIndex == 5) {
          return Center(
            child: DailyPlanPageContent(),
          );
        }
        return MyAccountPageContent(
          email: widget.user.email,
          
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
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
            icon: Icon(Icons.sports_martial_arts_sharp),
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
