import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThirdWelcomePage extends StatelessWidget {
  const ThirdWelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final list = [
      AppLocalizations.of(context)!.quote1,
      AppLocalizations.of(context)!.quote2,
      AppLocalizations.of(context)!.quote3,
      AppLocalizations.of(context)!.quote4,
      AppLocalizations.of(context)!.quote5,
      AppLocalizations.of(context)!.quote6,
      AppLocalizations.of(context)!.quote7,
    ];
    final element = list[random.nextInt(list.length)];
    final list2 = ['images/rocky2.jpg', 'images/lion2.jpg'];
    final randomImage = list2[random.nextInt(list2.length)];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context)!.welcome9,
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
                      AppLocalizations.of(context)!.welcome10,
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
