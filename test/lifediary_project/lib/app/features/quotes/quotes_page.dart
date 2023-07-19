import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/data/remote_data_sources/quotes_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';

import 'package:lifediary_project/app/features/instruction/instruction_page.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/features/login/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/features/quotes/cubit/quotes_cubit.dart';
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
  bool isQuoteHide = true;

  void toogleButton() {
    isQuoteHide = !isQuoteHide;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuotesCubit(QuotesRepository(QuotesRemoteDataSource()))..start(),
      child: BlocConsumer<QuotesCubit, QuotesState>(
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
          final quotesModel = state.quotes;
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
                      if (isQuoteHide == false) ...[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Expanded(
                            child: Column(
                              children: [
                                for (final quote in state.quotes) ...[
                                  RandomQuoteContainer(
                                    quotesModel: quote,
                                  ),
                                ],
                                SizedBox(height: 20),
                                AuthorHistoryButton(),
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

class RandomQuoteContainer extends StatelessWidget {
  const RandomQuoteContainer({
    super.key,
    required this.quotesModel,
  });

  final QuotesModel quotesModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            quotesModel.content,
            style: GoogleFonts.buenard(
              fontSize: 20,
              color: Colors.yellow[400],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          Text(
            quotesModel.authorName,
            style: GoogleFonts.buenard(
              fontSize: 22,
              color: Colors.yellow[400],
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      )),
    );
  }
}

class AuthorHistoryButton extends StatelessWidget {
  const AuthorHistoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.indigo[700]),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      icon: const Icon(Icons.search, color: Colors.yellow),
      label: Text(
        'Poznaj historię autora',
        style: GoogleFonts.buenard(
          fontSize: 20,
          color: Colors.yellow[400],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
