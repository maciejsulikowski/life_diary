import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.instruction_page,
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
                                text: AppLocalizations.of(context)!.account_1,
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.person),
                                ),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.account_2,
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
                                text: AppLocalizations.of(context)!.diary_1,
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.book),
                                ),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.diary_2,
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
                                text: AppLocalizations.of(context)!.training_1,
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.sports_martial_arts),
                                ),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.training_2,
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
                                text: AppLocalizations.of(context)!.water_1,
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.water_drop),
                                ),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.water_2,
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
                                text: AppLocalizations.of(context)!.todolist_1,
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.fact_check_outlined),
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.todolist_2,
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
                                text: AppLocalizations.of(context)!.plan_1,
                                style: GoogleFonts.buenard(
                                    fontSize: 20,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(Icons.lock_clock),
                                ),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.plan_2,
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
