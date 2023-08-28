import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:lifediary_project/app/features/stories/cubit/stories_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

import 'cubit/stories_cubit.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({
    Key? key,
    required this.author,
  }) : super(key: key);

  final QuotesModel author;

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StoriesCubit>()..fetchData(authorID: widget.author.id),
      child: BlocConsumer<StoriesCubit, StoriesState>(
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
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'STORIES PAGE',
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
                  return ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            for (final story in state.stories) ...[
                              RandomQuoteContainer(
                                storiesModel: story,
                              ),
                            ],
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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
    required this.storiesModel,
  });

  final StoriesModel storiesModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StoriesCubit>(),
      child: BlocBuilder<StoriesCubit, StoriesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(storiesModel.picture),
                    ),
                    if (state.status == Status.loading)
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors
                            .black, // Czarne tło, które pojawi się na chwilę podczas ładowania
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  'Źródło:',
                  style: GoogleFonts.buenard(
                    fontSize: 16,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  storiesModel.source,
                  style: GoogleFonts.buenard(
                    fontSize: 14,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Text(
                  storiesModel.bio,
                  style: GoogleFonts.buenard(
                    fontSize: 22,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
