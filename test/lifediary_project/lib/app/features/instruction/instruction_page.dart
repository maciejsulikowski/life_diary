import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'INSTRUCTION PAGE',
          style: GoogleFonts.buenard(
            fontSize: 22,
            color: Colors.yellow[400],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.indigo[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Konto - kliknij w',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.person),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'aby sprawdzić informację o koncie użytkownika!',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.indigo[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Dziennik - kliknij w',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.book),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'aby móc stworzyć swoje własne dzienniki!',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.indigo[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Trening - kliknij w',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.sports_martial_arts),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'aby móc dodawać swoje zdjęcia i później je porównywać!',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.indigo[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Woda - kliknij w',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.water_drop),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'aby móc dowiedzieć się ile wody powinieneś pić!',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.indigo[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'ToDoList - kliknij w',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.fact_check_outlined),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'aby sprawdzić informację o koncie użytkownika!',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.indigo[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Plan dnia - kliknij w',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.lock_clock),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'aby móc zaplanować swój dzień dodając swój własny plan!',
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
