import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_cubit.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';

class ToDoListContent extends StatefulWidget {
  const ToDoListContent({
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
                  'TODOLIST',
                  style: GoogleFonts.lato(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.blue,
                actions: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: Text(
                      'Dodaj zadanie',
                      style: GoogleFonts.lato(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
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
                  ),
                ],
              ),
              body: state.errorMessage.isNotEmpty
                  ? Text('Wystapil blad: ${state.errorMessage}')
                  : state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          color: Colors.blueAccent[700],
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                  controller: controller,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 2.0),
                                    ),
                                    hintText: 'Tu wpisz nazwę zadania',
                                    hintStyle: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
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
                            ],
                          ),
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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      child: Text(
        itemModel.title,
        style: TextStyle(color: Colors.blue[900], fontSize: 20),
      ),
    );
  }
}
