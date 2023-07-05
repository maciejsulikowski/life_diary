import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';

import 'package:lifediary_project/app/features/instruction/instruction_page.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/features/login/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  late IconData icon;
  late Color iconColor;
  bool isWeatherHide = true;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();

    icon = Icons.question_mark;
    iconColor = Colors.yellow[400]!;
    controller.addListener(onTextChanged);
    super.initState();
  }

  void onSearchClicked() {
    if (controller.text.isNotEmpty) {
      context.read<WeatherCubit>().getWeatherModel(city: controller.text);
    }
  }

  void onTextChanged() {
    setState(() {
      if (controller.text.isEmpty) {
        icon = Icons.question_mark;
        iconColor;
      } else {
        icon = Icons.search;
        iconColor;
      }
    });
  }

  void toogleButton() {
    isWeatherHide = !isWeatherHide;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherCubit>(),
      child: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unknown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final weatherModel = state.model;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'QUOTES PAGE',
                style: GoogleFonts.buenard(
                    fontSize: 22,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.black87,
            ),
            body: Container(
              color: Colors.black87,
              child: Center(
                child: Builder(builder: (context) {
                  if (state.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      const Image(
                        image: AssetImage('images/quote.png'),
                        width: 100,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo[700]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Wylosuj cytat 🎲',
                          style: GoogleFonts.buenard(
                            fontSize: 20,
                            color: Colors.yellow[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            toogleButton();
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      if (isWeatherHide == false) ...[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                                    style: GoogleFonts.buenard(
                                      fontSize: 20,
                                      color: Colors.yellow[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.indigo[700]),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(Icons.search,
                                      color: Colors.yellow),
                                  label: Text(
                                    'Poznaj historię autora',
                                    style: GoogleFonts.buenard(
                                      fontSize: 20,
                                      color: Colors.yellow[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
