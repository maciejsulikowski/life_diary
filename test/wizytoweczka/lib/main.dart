import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/ronaldinho.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/oblazek.jpg'),
                  radius: 100,
                ),
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Maciej Sulikowski',
                  style: GoogleFonts.anton(
                    fontSize: 40,
                    color: Colors.yellow,
                  ),
                ),
                Text(
                  'Flutter Developer',
                  style: GoogleFonts.pacifico(
                    fontSize: 40,
                    color: Colors.yellow,
                  ),
                ),
                Text(
                  'maciek5882@gmail.com',
                  style: GoogleFonts.pacifico(
                    fontSize: 20,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.email,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
