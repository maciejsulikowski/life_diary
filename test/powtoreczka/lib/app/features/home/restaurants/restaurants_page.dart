import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:powtoreczka/app/features/details/pages/details_page.dart';
import 'package:powtoreczka/app/features/home/restaurants/cubit/restaurants_cubit.dart';
import 'package:powtoreczka/app/repositories/items_repository.dart';

class OpinionPage extends StatelessWidget {
  const OpinionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime release_date;
    return BlocProvider(
      create: (context) => RestaurantsCubit(ItemsRepository())..start(),
      child: BlocListener<RestaurantsCubit, RestaurantsState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                ),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state.isLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
          builder: (context, state) {
            final itemModels = state.documents;
            final List<Color> circleColors = [
              Colors.red,
              Colors.blue,
              Colors.green
            ];

            Color randomGenerator() {
              return circleColors[new Random().nextInt(3)];
            }

            return ListView(
              children: [
                for (final itemModel in itemModels) ...[
                  SizedBox(height: 20),
                  Dismissible(
                    key: ValueKey(itemModel.id),
                    background: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                      ),
                      child: Icon(Icons.delete),
                    ),
                    confirmDismiss: (direction) async {
                      return direction == DismissDirection.endToStart;
                    },
                    onDismissed: (direction) {
                      context
                          .read<RestaurantsCubit>()
                          .remove(documentID: itemModel.id);
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(id: itemModel.id),
                          ),
                        );
                      },
                      child: Container(
                        color: randomGenerator(),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(itemModel.name),
                                  Text(itemModel.pizza),
                                  Text(
                                    DateFormat.MMMEd()
                                        .format(itemModel.releaseDate),
                                  )
                                ],
                              ),
                              Text(
                                itemModel.rating.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
