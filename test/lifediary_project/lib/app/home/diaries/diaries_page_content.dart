import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/add_page/add_page.dart';
import 'package:lifediary_project/app/details/pages/details_page.dart';
import 'package:lifediary_project/app/home/diaries/cubit/diares_cubit.dart';
import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';

int maxDiaryCount = 3;
int currentDiaryCounter = 0;

class DiariesPageContent extends StatefulWidget {
  const DiariesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DiariesPageContent> createState() => _DiariesPageContentState();
}

class _DiariesPageContentState extends State<DiariesPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _NewDiary(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
              fullscreenDialog: true,
            ),
          );
          currentDiaryCounter++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _NewDiary extends StatelessWidget {
  const _NewDiary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiaresCubit(ItemsRepository())..start(),
      child: BlocBuilder<DiaresCubit, DiaresState>(
        builder: (context, state) {
          final itemModels = state.items;
          if (itemModels.isEmpty) {
            return const SizedBox.shrink();
          }
          return ListView(
            children: [
              for (final itemModel in itemModels)
                Dismissible(
                  key: ValueKey(itemModel.id),
                  background: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) {
                    context
                        .read<DiaresCubit>()
                        .remove(documentID: itemModel.id);
                  },
                  child: ListViewItem(
                    itemModel: itemModel,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsPageContent(
              id: itemModel.id,
              itemModel: itemModel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                    image: NetworkImage(
                      itemModel.imageURL,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            itemModel.title,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            itemModel.releaseDateFormatted(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
