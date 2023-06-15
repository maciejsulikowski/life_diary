import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';

import 'package:lifediary_project/app/features/instruction/instruction_page.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/features/login/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
      //api
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
    return BlocBuilder<SubjectBloc, SubjectState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'WEATHER PAGE',
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
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("images/math.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Image(
                      image: AssetImage('images/cloud.png'),
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
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
                      icon: const Icon(Icons.search, color: Colors.yellow),
                      label: Text(
                        'Sprawdź pogodę',
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
                      TextField(
                        controller: controller,
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 22,
                          fontFamily: GoogleFonts.buenard().fontFamily,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Wpisz miasto...',
                          hintStyle: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 22,
                            fontFamily: GoogleFonts.buenard().fontFamily,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromRGBO(255, 238, 88, 1),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              icon,
                              color: iconColor,
                            ),
                            onPressed: onSearchClicked,
                          ),
                        ),
                      ),
                      WeatherWidget(
                        weatherModel: w,
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    required this.weatherModel,
    super.key,
  });

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weatherModel.temperature.toString(),
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 60),
        Text(
          weatherModel.city,
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
