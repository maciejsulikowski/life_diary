import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/welcome/second_welcome_page.dart';
import 'package:lifediary_project/app/features/welcome/third_welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  final PageController controller = PageController(initialPage: 0);
  int currentPage = 0;
  final List<Widget> pages = [
    const FirstWelcomePage(),
    const SecondWelcomePage(),
    const ThirdWelcomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemCount: pages.length,
            itemBuilder: (BuildContext context, int index) {
              return pages[index % pages.length];
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  pages.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: currentPage == index
                                ? Colors.grey
                                : Colors.white,
                          ),
                        ),
                      )),
            ),
          ),
        ],
      ),
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
      body: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.867),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              const Image(
                image: AssetImage('images/black_diary.png'),
                width: 100,
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.welcome1,
                style: GoogleFonts.buenard(
                  fontSize: 22,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
