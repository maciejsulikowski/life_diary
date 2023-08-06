import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';
import 'package:lifediary_project/app/features/water/cubit/water_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WaterPage> createState() => WaterPageState();
}

class WaterPageState extends State<WaterPage> {
  final heightController = TextEditingController();

  final weightController = TextEditingController();

  var result = 0;
  var glassResult = 0;
  var glass = 330;

  var isAnswered = false;
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WaterCubit>(),
      child: BlocBuilder<WaterCubit, WaterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'WODA',
                style: GoogleFonts.buenard(
                    fontSize: 22,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.black87,
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/water.jpg"), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Ile szklanek wody powinieneś pić dziennie?',
                        style: GoogleFonts.buenard(
                            fontSize: 18,
                            color: Colors.indigo[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: heightController,
                      style: TextStyle(
                        color: Colors.yellow[400],
                        fontSize: 22,
                        fontFamily: GoogleFonts.buenard().fontFamily,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.indigo[700],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Tutaj napisz swój wzrost w cm np. 180',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.yellow[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: weightController,
                      style: TextStyle(
                        color: Colors.yellow[400],
                        fontSize: 22,
                        fontFamily: GoogleFonts.buenard().fontFamily,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.indigo[700],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Tutaj napisz swoją wagę w kg np. 80',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.yellow[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (heightController.text.isEmpty ||
                          weightController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    "Wprowadź wszystkie dane!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        return;
                      }

                      // Sprawdzenie, czy dane w heightController i weightController są liczbami
                      if (double.tryParse(heightController.text) == null ||
                          double.tryParse(weightController.text) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    "Podaj tylko liczby!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        return;
                      }

                      // Obliczenia i zapis do Cubit
                      setState(() {
                        isAnswered = true;
                        result =
                            (30 * double.parse(weightController.text)).toInt();
                        glassResult = (result / glass).floor();
                        answer = glassResult.toString();
                        context.read<WaterCubit>().saveGlasses(answer);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Oblicz!',
                      style: GoogleFonts.buenard(
                          fontSize: 20,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isAnswered == true) ...[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Powinieneś pić około $result ml wody!',
                              style: GoogleFonts.buenard(
                                  fontSize: 24,
                                  color: Colors.indigo[700],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Co daje gdzieś $glassResult szklanek wody dziennie!',
                              style: GoogleFonts.buenard(
                                  fontSize: 24,
                                  color: Colors.indigo[700],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}