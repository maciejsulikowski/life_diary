import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/login/login_page.dart';
import 'package:lifediary_project/app/welcome/second_welcome_page.dart';
import 'package:lifediary_project/app/welcome/third_welcome_page.dart';

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: <Widget>[
        FirstWelcomePage(),
        SecondWelcomePage(),
        ThirdWelcomePage(),
        LoginPage(),
      ],
    );
  }
}

class FirstWelcomePage extends StatelessWidget {
  const FirstWelcomePage({
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
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Witaj w aplikacji LifeDiary!',
                  style: GoogleFonts.lato(
                      fontSize: 22,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage('images/magic-wand.png'),
                    width: 120,
                  ),
                  Image(
                    image: AssetImage('images/magic-wand2.png'),
                    width: 120,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Text('Przesuń w lewo, aby iść dalej !',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold)),
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
