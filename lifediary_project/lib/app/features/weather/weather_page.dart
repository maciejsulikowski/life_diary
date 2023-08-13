import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_state.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.weather_page,
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
                          AppLocalizations.of(context)!.check_weather,
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
                      const SizedBox(height: 20),
                      if (isWeatherHide == false) ...[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller,
                                      style: TextStyle(
                                        color: Colors.yellow[400],
                                        fontSize: 22,
                                        fontFamily:
                                            GoogleFonts.buenard().fontFamily,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .check_city,
                                        hintStyle: TextStyle(
                                          color: Colors.yellow[400],
                                          fontSize: 22,
                                          fontFamily:
                                              GoogleFonts.buenard().fontFamily,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromRGBO(255, 238, 88, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.yellow,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo[700],
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<WeatherCubit>()
                                          .getWeatherModel(
                                              city: controller.text);
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '🔎',
                                        style: TextStyle(
                                          color: Colors.yellow[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (weatherModel != null) ...[
                        Expanded(
                          child: WeatherWidget(
                            weatherModel: weatherModel,
                          ),
                        )
                      ]
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

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    required this.weatherModel,
    super.key,
  });

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weatherModel.current.temp.toString(),
              style: GoogleFonts.buenard(
                fontSize: 40,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              weatherModel.location.name,
              style: GoogleFonts.buenard(
                fontSize: 46,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
