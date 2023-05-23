import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdWelcomePage extends StatelessWidget {
  const ThirdWelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final list = [
      '"Jeśli uważasz, że coś potrafisz to masz rację, jeśli uważasz że czegoś nie potrafisz, to także masz rację!"  Henry Ford"',
      '"Twój czas jest ograniczony, więc nie marnuj go na bycie kimś kim nie jesteś!  Steve Jobs"',
      '"Żeby poznać słodki smak życia, musisz najpierw poznać jego gorycz. Vanilla Sky"',
      '"Nie bój się tego, że Twoje życie kiedyś się skończy, bój się tego, że nigdy może się nie zacząć! Krzysztof Król"',
      '"Nie trafiłem ponad 9000 rzutów w moim życiu. Przegrałem ponad 300 meczów. 26 razu zaufano mi, gdy miałem oddać rzut na miarę zwycięstwa i spudłowałem. Przegrywałem w moim życiu ciągle. Dlatego właśnie osiągnąłem sukces."  Michael Jordan',
      '"Nic nie jest podawane na tacy – każdy zawsze trafia na jakieś przeszkody po drodze. Kiedy się pojawią, zastanów się jak je pokonać, a nie myśl o tym, że to już koniec drogi." Michael Jordan',
      '"Ludzie, którzy tracą czas czekając, aż zaistnieją najbardziej sprzyjające warunki, nigdy nic nie zdziałają. Najlepszy czas na działanie jest teraz!" Mark Fisher'
    ];
    final element = list[random.nextInt(list.length)];
    final list2 = ['images/rocky.jpg', 'images/lion.jpg'];
    final randomImage = list2[random.nextInt(list2.length)];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Oto Twój cytat, przesuń w lewo',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(randomImage.toString()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              element,
              style: GoogleFonts.lato(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]));
  }
}
