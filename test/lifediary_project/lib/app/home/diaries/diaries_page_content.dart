import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/add_page/add_page.dart';
import 'package:lifediary_project/app/home/diaries/cubit/diares_cubit.dart';

class DiariesPageContent extends StatefulWidget {
  const DiariesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DiariesPageContent> createState() => _DiariesPageContentState();
}

class _DiariesPageContentState extends State<DiariesPageContent> {
  int maxDiaryCount = 4;
  int currentDiaryCounter = 0;

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
      create: (context) => DiaresCubit()..start(),
      child: BlocBuilder<DiaresCubit, DiaresState>(
        builder: (context, state) {
          final docs = state.items?.docs;
          if (docs == null) {
            return const SizedBox.shrink();
          }
          return ListView(
            children: [
              for (final doc in docs)
                Dismissible(
                  key: ValueKey(doc.id),
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
                    context.read<DiaresCubit>().remove(documentID: doc.id);
                  },
                  child: ListViewItem(
                    document: doc,
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
    required this.document,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    document['image_url'],
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
                          document['title'],
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (document['release_date'] as Timestamp)
                              .toDate()
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        '0',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('days left'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
