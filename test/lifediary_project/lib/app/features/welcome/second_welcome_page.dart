import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/welcome/second_welcome_page.dart';
import 'package:lifediary_project/app/features/welcome/third_welcome_page.dart';

class SecondWelcomePage extends StatelessWidget {
  const SecondWelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/happyskalmar.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Cieszę się, że tu jesteś! 👋',
                  style: GoogleFonts.lato(
                      fontSize: 26,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Jesteś w aplikacji, która pomoże Ci uporządkować twoje myśli, treningi i Twoje całe życie! 💪',
                  style: GoogleFonts.lato(
                      fontSize: 26,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'Skalmar już wie, że dzięki tej aplikacji będzie Ci się fajniej i łatwiej żyło! 🤩😎',
                    style: GoogleFonts.lato(
                        fontSize: 26,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'A teraz przesuń w lewo i wylosuj swój cytat, aby się zmotywować! 👈',
                    style: GoogleFonts.lato(
                        fontSize: 26,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
