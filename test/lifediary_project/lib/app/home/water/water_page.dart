import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/diaries/diaries_page_content.dart';
import 'package:lifediary_project/app/home/my_account/my_account_page_content.dart';
import 'package:lifediary_project/app/home/to_do_list/to_do_list_content.dart';
import 'package:lifediary_project/app/home/water/water_page.dart';
import 'package:lifediary_project/app/login/login_page.dart';

class WaterPage extends StatelessWidget {
  WaterPage({
    Key? key,
  }) : super(key: key);

  final first_controller = TextEditingController();
  final second_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/water.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Ile szklanek wody powinieneś pić dziennie?',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: first_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tutaj napisz swój wzrost',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: second_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tutaj napisz swoją wagę',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
