import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/to_do_list/cubit/to_do_list_cubit.dart';

class ToDoListContent extends StatelessWidget {
  ToDoListContent({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  var error = 'Pole nie może być puste';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Wprowadź jakieś zadanie!"),
              ),
            );
            return;
          }
          FirebaseFirestore.instance.collection('categories').add(
            {
              'title': controller.text,
            },
          );

          controller.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => ToDoListCubit()..start(),
        child: BlocBuilder<ToDoListCubit, ToDoListState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text('Wystapil blad: ${state.errorMessage}');
            }
            if (state.isLoading) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }

            final documents = state.documents;
            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('categories')
                          .doc(document.id)
                          .delete();
                    },
                    child: CategoryWidget(
                      document['title'],
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: 'Tu wpisz nazwę zadania'),
                  ),
                ),
              ],
            );

            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (context, snapshot) {});
          },
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(title),
    );
  }
}
