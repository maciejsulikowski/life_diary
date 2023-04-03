import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:powtoreczka/app/features/details/cubit/details_cubit.dart';

import 'package:powtoreczka/app/repositories/items_repository.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(ItemsRepository())..getItemWithID(id),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          final itemModel = state.itemModel;
          if (itemModel == null) {
            return CircularProgressIndicator();
          }
          final List<Color> circleColors = [
            Colors.red,
            Colors.blue,
            Colors.green
          ];

          return Expanded(
            child: ListView(
              children: [
                Container(
                  color: Colors.amber,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
