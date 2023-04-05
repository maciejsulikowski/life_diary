import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:powtoreczka/app/features/details/pages/details_page.dart';
import 'package:powtoreczka/app/features/home/all_things/cubit/all_things_cubit.dart';
import 'package:powtoreczka/app/features/home/restaurants/cubit/restaurants_cubit.dart';
import 'package:powtoreczka/app/repositories/items_repository.dart';

class AllThingsPage extends StatelessWidget {
  const AllThingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllThingsCubit()..start(),
      child: BlocBuilder<AllThingsCubit, AllThingsState>(
        builder: (context, state) {
          final itemModels = state.documents;
          if (state.isLoading) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: [
              for (final itemModel in itemModels) ...[
                SizedBox(height: 20),
                // Dismissible(
                //   key: ValueKey(itemModel.id),
                //   background: DecoratedBox(
                //     decoration: BoxDecoration(
                //       color: Colors.yellow,
                //     ),
                //     child: Icon(Icons.delete),
                //   ),
                //   confirmDismiss: (direction) async {
                //     return direction == DismissDirection.endToStart;
                //   },
                //   onDismissed: (direction) {
                //     context
                //         .read<RestaurantsCubit>()
                //         .remove(documentID: itemModel.id);
                //   },
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => DetailsPage(id: itemModel.id),
                //         ),
                //       );
                //     },
                Container(
                  color: Colors.blue,
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
                              DateFormat.MMMEd().format(itemModel.releaseDate),
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
              ]
            ],
          );
        },
      ),
    );
  }
}
