import 'dart:math';

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
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prawda czy fałsz?"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wypowiedz pytanie!",
              style: GoogleFonts.anton(
                fontSize: 40,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SecondPage(),
                    ),
                  );
                },
                child: Text("CHECK!"),
                style: ElevatedButton.styleFrom(primary: Colors.yellow)),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final result = random.nextBool();
    return Scaffold(
      appBar: AppBar(
        title: Text("Prawda czy fałsz?"),
        backgroundColor: result == true ? Colors.green : Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: result == true
                    ? AssetImage("images/bad.jpg")
                    : AssetImage("images/good.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (result == true)
                Text(
                  "KŁAMIESZ!",
                  style: GoogleFonts.anton(
                    fontSize: 40,
                    color: Colors.red[600],
                  ),
                ),
              if (result == false)
                Text(
                  "PRAWDA!",
                  style: GoogleFonts.anton(
                    fontSize: 40,
                    color: Colors.blue[600],
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: result == true
                    ? Text("Popraw się dzbanie!")
                    : Text("Dobrze, oby tak dalej!"),
                style: ElevatedButton.styleFrom(
                  primary: (result == true ? Colors.red : Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
