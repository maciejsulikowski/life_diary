import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiariesPageContent extends StatefulWidget {
  const DiariesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DiariesPageContent> createState() => _DiariesPageContentState();
}

class _DiariesPageContentState extends State<DiariesPageContent> {
  List<NewDiary> newDiaries = [];
  int maxDiaryCount = 4;
  int currentDiaryCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentDiaryCounter < maxDiaryCount) {
            setState(() {
              newDiaries.add(const NewDiary());
              currentDiaryCounter++;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Możesz maksymalnie mieć 4 dzienniki."),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Utwórz dziennik, klikając przycisk poniżej',
            ),
          ),
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: newDiaries.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  newDiaries[index],
                  const SizedBox(height: 40),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class NewDiary extends StatelessWidget {
  const NewDiary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Wrap(
          children: const [
            Icon(Icons.add, size: 60),
          ],
        ),
      ),
    );
  }
}
