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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LifeDiary')),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Witaj w aplikacji LifeDiary!',
                  style: GoogleFonts.lato(fontSize: 22, color: Colors.yellow),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage('images/magic-wand.png'),
                    width: 100,
                  ),
                  Image(
                    image: AssetImage('images/magic-wand2.png'),
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Text('Przesuń w lewo, aby iść dalej !',
                  style: GoogleFonts.lato(fontSize: 20, color: Colors.yellow)),
              const SizedBox(height: 50),
              const Image(
                image: AssetImage('images/diary.png'),
                width: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
