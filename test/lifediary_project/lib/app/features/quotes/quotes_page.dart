import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/data/remote_data_sources/quotes_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:lifediary_project/app/features/quotes/cubit/quotes_cubit.dart';
import 'package:lifediary_project/app/features/stories/stories_page.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool isQuoteHide = true;
  int lastRandomIndex = -1;

  void toogleButton() {
    isQuoteHide = !isQuoteHide;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuotesCubit(QuotesRepository(QuotesRemoteDioDataSource()))..start(),
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
          if (quotesModel.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'QUOTES PAGE',
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
                  child: Center(child: CircularProgressIndicator())),
            );
          }

          final result = quotesModel[Random().nextInt(quotesModel.length)];
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'QUOTES PAGE',
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
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                RandomQuoteContainer(
                                  quotesModel: result,
                                ),
                                SizedBox(height: 20),
                                AuthorHistoryButton(
                                  model: result,
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

class RandomQuoteContainer extends StatelessWidget {
  const RandomQuoteContainer({
    Key? key,
    required this.quotesModel,
  }) : super(key: key);

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
                fontSize: 24,
                color: Colors.yellow[400],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Text(
              quotesModel.authorName,
              style: GoogleFonts.buenard(
                fontSize: 26,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthorHistoryButton extends StatelessWidget {
  const AuthorHistoryButton({
    Key? key,
    required this.model,
  }) : super(key: key);

  final QuotesModel model;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StoriesPage(author: model),
          ),
        );
      },
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
