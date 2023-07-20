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
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:lifediary_project/app/domain/repositories/stories_repository.dart';
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

import '../../data/remote_data_sources/stories_remote_data_source.dart';
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
          StoriesCubit(StoriesRepository(StoriesRemoteDioDataSource()))
            ..fetchData(authorID: widget.author.id),
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Expanded(
                          child: Column(
                            children: [
                              for (final story in state.stories) ...[
                                RandomQuoteContainer(
                                  storiesModel: story,
                                ),
                              ],
                              SizedBox(height: 20),
                            ],
                          ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(storiesModel.picture),
              radius: 80,
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Źródło:',
            style: GoogleFonts.buenard(
              fontSize: 16,
              color: Colors.yellow[400],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            storiesModel.source,
            style: GoogleFonts.buenard(
              fontSize: 16,
              color: Colors.yellow[400],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
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
      )),
    );
  }
}
