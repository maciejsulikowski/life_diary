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
      // appBar: AppBar(
      //   backgroundColor: Colors.black87,
      //   title: Text(
      //     'LIFEDIARY',
      //     style: GoogleFonts.buenard(
      //         fontSize: 24,
      //         color: Colors.yellow[400],
      //         fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Do czego jest LIFEDIARY? 🤔',
                    style: GoogleFonts.buenard(
                        fontSize: 24,
                        color: Colors.yellow[400],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: AssetImage('images/diarywithpen.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Do tworzenia nowych dzienników i zapisywania Twojego progresu!',
                        style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/instagramm.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Do tworzenia nowych zdjęć, w celu ciągłego progresu!',
                        style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/water.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Do określenia ile wody powinieneś pić!',
                        style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/todolist.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Do zaplanowania i zrobienia skutecznej listy zadań!',
                        style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/time.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Do zaplanowania swojego dnia!',
                        style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                        'A teraz przesuń w lewo i wylosuj swój cytat, aby się zmotywować! 👈',
                        style: GoogleFonts.buenard(
                            fontSize: 24,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
