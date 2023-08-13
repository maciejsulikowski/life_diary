import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';

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
      '"Nie trafiłem ponad 9000 rzutów w moim życiu. Przegrałem ponad 300 meczów. 26 razy zaufano mi, gdy miałem oddać rzut na miarę zwycięstwa i spudłowałem. Przegrywałem w moim życiu ciągle. Dlatego właśnie osiągnąłem sukces."  Michael Jordan',
      '"Nic nie jest podawane na tacy – każdy zawsze trafia na jakieś przeszkody po drodze. Kiedy się pojawią, zastanów się jak je pokonać, a nie myśl o tym, że to już koniec drogi." Michael Jordan',
      '"Ludzie, którzy tracą czas czekając, aż zaistnieją najbardziej sprzyjające warunki, nigdy nic nie zdziałają. Najlepszy czas na działanie jest teraz!" Mark Fisher'
    ];
    final element = list[random.nextInt(list.length)];
    final list2 = ['images/rocky2.jpg', 'images/lion2.jpg'];
    final randomImage = list2[random.nextInt(list2.length)];

    Color textColor = Colors.yellow;
    if (randomImage == 'images/rocky2.jpg') {
      textColor = Colors.white;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Oto Twój cytat !',
            style: GoogleFonts.buenard(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Container(
            color: Colors.black87,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(randomImage.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    element,
                    style: GoogleFonts.buenard(
                        fontSize: 22,
                        color: Colors.yellow[400],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(48, 63, 159, 1)),
                    ),
                    child: Text(
                      'Zaczynamy!',
                      style: GoogleFonts.buenard(
                        fontSize: 22,
                        color: Colors.yellow[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
