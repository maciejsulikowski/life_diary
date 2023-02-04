import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/to_do_list/cubit/to_do_list_cubit.dart';
import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';

class ToDoListContent extends StatefulWidget {
  ToDoListContent({
    Key? key,
  }) : super(key: key);

  @override
  State<ToDoListContent> createState() => _ToDoListContentState();
}


class _ToDoListContentState extends State<ToDoListContent> {
  final controller = TextEditingController();

  var error = 'Pole nie może być puste';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoListCubit(ItemsRepository())..start(),
      child: BlocListener<ToDoListCubit, ToDoListState>(
        listener: (context, state) {
          if (state.saved) {
            context.read<ToDoListCubit>().start();
          }
        },
        child: BlocBuilder<ToDoListCubit, ToDoListState>(
          builder: (context, state) {
            final itemModels = state.documents;
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
                  context.read<ToDoListCubit>().addtask(controller.text);
                  controller.clear();
                },
                child: const Icon(Icons.add),
              ),
              body: state.errorMessage.isNotEmpty
                  ? Text('Wystapil blad: ${state.errorMessage}')
                  : state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
                          children: [
                            for (final itemModel in itemModels) ...[
                              Dismissible(
                                key: ValueKey(itemModel.id),
                                onDismissed: (_) {
                                  context
                                      .read<ToDoListCubit>()
                                      .remove(documentID: itemModel.id);
                                },
                                child: CategoryWidget(
                                  itemModel: itemModel,
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
                        ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModelToDoList itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(itemModel.title),
    );
  }
}
