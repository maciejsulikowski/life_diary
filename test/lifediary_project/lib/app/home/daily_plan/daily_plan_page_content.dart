import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/diaries/diaries_page_content.dart';
import 'package:lifediary_project/app/home/my_account/my_account_page_content.dart';
import 'package:lifediary_project/app/home/to_do_list/to_do_list_content.dart';
import 'package:lifediary_project/app/home/training/training_page_content.dart';
import 'package:lifediary_project/app/home/water/water_page.dart';
import 'package:lifediary_project/app/login/login_page.dart';

class DailyPlanPageContent extends StatefulWidget {
  DailyPlanPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyPlanPageContent> createState() => _DailyPlanPageContentState();
}

class _DailyPlanPageContentState extends State<DailyPlanPageContent> {
  int currentHour = 6;
  int newHour = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PLAN DNIA',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            maxWidth: 80,
          ),
          child: ListView(
            children: [
              for (var i = 0; i < 19; i++) ...[
                TimeContainer(currentHour: currentHour + i),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    required this.currentHour,
    Key? key,
  }) : super(key: key);

  final int currentHour;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        color: Colors.amber,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        child: Text('$currentHour:00'));
  }
}
