import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';
import 'package:lifediary_project/app/features/water/cubit/water_state.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.water,
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
                    image: AssetImage("images/water6.jpg"), fit: BoxFit.cover),
              ),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        AppLocalizations.of(context)!.glasses,
                        style: GoogleFonts.buenard(
                            fontSize: 18,
                            color: Colors.yellow[400],
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
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
                        hintText: AppLocalizations.of(context)!.water_height,
                        hintStyle: TextStyle(
                          fontSize: 15,
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
                        hintText: AppLocalizations.of(context)!.water_weight,
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.yellow[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                  content: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.error,
                                            color: Colors.white),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .change_data,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              return;
                            }

                            // Sprawdzenie, czy dane w heightController i weightController są liczbami
                            if (double.tryParse(heightController.text) ==
                                    null ||
                                double.tryParse(weightController.text) ==
                                    null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.error,
                                            color: Colors.white),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppLocalizations.of(context)!.count_2,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                  (30 * double.parse(weightController.text))
                                      .toInt();
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
                            AppLocalizations.of(context)!.count,
                            style: GoogleFonts.buenard(
                                fontSize: 20,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
                              '${AppLocalizations.of(context)!.drink_1} $result ${AppLocalizations.of(context)!.drink_2}',
                              style: GoogleFonts.buenard(
                                  fontSize: 26,
                                  color: Colors.yellow[400],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${AppLocalizations.of(context)!.drink_3} $glassResult ${AppLocalizations.of(context)!.drink_4}',
                              style: GoogleFonts.buenard(
                                  fontSize: 26,
                                  color: Colors.yellow[400],
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
