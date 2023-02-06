import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyPlanPageContent extends StatefulWidget {
  DailyPlanPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyPlanPageContent> createState() => _DailyPlanPageContentState();
}

class _DailyPlanPageContentState extends State<DailyPlanPageContent> {
  List<TextEditingController> _controller =
      List.generate(21, (i) => TextEditingController());
  

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 80,
            maxWidth: 400,
          ),
          child: ListView(
            children: [
              for (var i = 0; i < 19; i++) ...[
                Row(
                  children: [
                    Column(
                      children: [
                        TimeContainer(
                          currentHour: currentHour + i,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          PartOfPlanning(
                            controller: _controller,
                            index: i,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
        width: 80,
        height: 88,
        color: Colors.green,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        child: Text('$currentHour:00'));
  }
}

class PartOfPlanning extends StatelessWidget {
  PartOfPlanning({
    required this.controller,
    required this.index,
    Key? key,
  }) : super(key: key);

  List<TextEditingController> controller =
      List.generate(18, (i) => TextEditingController());
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller[index],
        decoration: InputDecoration(hintText: 'Wpisz swój plan tutaj.. '),
      ),
    );
  }
}
