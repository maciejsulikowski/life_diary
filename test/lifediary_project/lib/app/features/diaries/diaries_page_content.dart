import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/features/add_page/add_page.dart';
import 'package:lifediary_project/app/features/details/pages/details_page.dart';
import 'package:lifediary_project/app/features/diaries/cubit/diares_cubit.dart';
import 'package:lifediary_project/app/features/diaries/cubit/diares_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

import '../../domain/repositories/items_repository.dart';

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
            'DZIENNIKI',
            style: GoogleFonts.buenard(
                fontSize: 22,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo[700]),
              ),
              icon: Icon(Icons.add, color: Colors.yellow[400]),
              label: Text(
                'Dodaj dziennik',
                style: GoogleFonts.buenard(
                    fontSize: 20,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ]),
      body: const _NewDiary(),
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
      create: (context) => getIt<DiaresCubit>()..start(),
      child: BlocBuilder<DiaresCubit, DiaresState>(
        builder: (context, state) {
          final itemModels = state.items;
          if (itemModels.isEmpty) {
            return Scaffold(
                body: Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Utwórz dziennik',
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 22,
                          fontFamily: GoogleFonts.buenard().fontFamily,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'klikając przycisk powyżej 👆',
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 22,
                          fontFamily: GoogleFonts.buenard().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }
          return Container(
            color: Colors.black87,
            child: ListView(
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
            ),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Container(
                  height: 180,
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
                        color: Colors.indigo[700],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                itemModel.title,
                                style: GoogleFonts.buenard(
                                    fontSize: 22,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Center(
                              child: Text(
                                itemModel.releaseDateFormatted(),
                                style: GoogleFonts.buenard(
                                    fontSize: 18,
                                    color: Colors.yellow[400],
                                    fontWeight: FontWeight.bold),
                              ),
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
      ),
    );
  }
}
