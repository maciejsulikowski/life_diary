import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondWelcomePage extends StatelessWidget {
  const SecondWelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final list = [
      '"Jeśli uważasz, że coś potrafisz to masz rację, jeśli uważasz że czegoś nie potrafisz, to także masz rację!"  Henry Ford"',
      '"Twój czas jest ograniczony, więc nie marnuj go na bycie kimś kim nie jesteś!  Steve Jobs"',
      '"Nie trafiłem ponad 9000 rzutów w moim życiu. Przegrałem ponad 300 meczów. 26 razu zaufano mi, gdy miałem oddać rzut na miarę zwycięstwa i spudłowałem. Przegrywałem w moim życiu ciągle. Dlatego właśnie osiągnąłem sukces."  Michael Jordan',
      '"Nic nie jest podawane na tacy – każdy zawsze trafia na jakieś przeszkody po drodze. Kiedy się pojawią, zastanów się jak je pokonać, a nie myśl o tym, że to już koniec drogi." Michael Jordan',
      '"Ludzie, którzy tracą czas czekając, aż zaistnieją najbardziej sprzyjające warunki, nigdy nic nie zdziałają. Najlepszy czas na działanie jest teraz!" Mark Fisher'
    ];
    final element = list[random.nextInt(list.length)];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Oto Twój cytat, Przesuń w lewo',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/rocky.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              element,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]));
  }
}
