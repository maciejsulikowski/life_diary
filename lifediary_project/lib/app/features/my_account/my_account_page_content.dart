import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/data/remote_data_sources/water_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:lifediary_project/app/features/instruction/instruction_page.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/features/login/user_profile.dart';
import 'package:lifediary_project/app/features/quotes/quotes_page.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';
import 'package:lifediary_project/app/features/water/cubit/water_state.dart';
import 'package:lifediary_project/app/features/weather/weather_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WaterCubit(WaterRepository(WaterRemoteDataSource()))..start(),
      child: BlocListener<WaterCubit, WaterState>(
        listener: (context, state) {
          if (state.isSaved) {
            context.read<WaterCubit>().start();
          }
        },
        child: BlocBuilder<WaterCubit, WaterState>(
          builder: (context, state) {
            final answer = state.glasses;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.main_page,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QuotesPage()),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.indigo[700],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.question_mark,
                                    color: Colors.yellow),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WeatherPage()),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.indigo[700],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.sunny,
                                    color: Colors.yellow),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Image(
                          image: AssetImage('images/black_diary.png'),
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo[700]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.person, color: Colors.yellow),
                          label: Text(
                            AppLocalizations.of(context)!.user_panel,
                            style: GoogleFonts.buenard(
                                fontSize: 20,
                                color: Colors.yellow[400],
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserProfile()),
                            );
                          },
                        ),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo[700]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          icon:
                              const Icon(Icons.pageview, color: Colors.yellow),
                          label: Text(
                            AppLocalizations.of(context)!.instruction,
                            style: GoogleFonts.buenard(
                                fontSize: 20,
                                color: Colors.yellow[400],
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InstructionPage()),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo[700],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            height: 30,
                            child: Center(
                              child: Text(
                                answer?.glasses == null
                                    ? AppLocalizations.of(context)!.remember_1
                                    : '${AppLocalizations.of(context)!.remember_2} ${answer?.glasses ?? ''} ${AppLocalizations.of(context)!.remember_3}',
                                style: GoogleFonts.buenard(
                                  fontSize: 20,
                                  color: Colors.yellow[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo[700]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.logout, color: Colors.yellow),
                          label: Text(
                            AppLocalizations.of(context)!.log_out,
                            style: GoogleFonts.buenard(
                                fontSize: 20,
                                color: Colors.yellow[400],
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            context.read<RootCubit>().signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                '${AppLocalizations.of(context)!.login_as} $email',
                                style: GoogleFonts.buenard(
                                    fontSize: 18,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
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
          },
        ),
      ),
    );
  }
}
