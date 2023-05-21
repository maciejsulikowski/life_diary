import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
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
  bool isChecked = false;
  var error = 'Pole nie może być puste';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoListCubit(TasksRepository())..start(),
      child: BlocListener<ToDoListCubit, ToDoListState>(
        listener: (context, state) {
          if (state.saved) {
            context.read<ToDoListCubit>().start();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wystąpił błąd'),
              ),
            );
          }
          if (state.isLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
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
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
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
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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
                      context
                          .read<ToDoListCubit>()
                          .addtask(controller.text, isChecked);
                      controller.clear();
                    },
                  ),
                ],
              ),
              body: Container(
                color: Colors.blueAccent[700],
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 20),
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2.0),
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
                          onCheckboxChanged: (value) {
                            setState(() {
                              itemModel.isChecked = value;
                            });
                          },
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

class CategoryWidget extends StatefulWidget {
  CategoryWidget({
    Key? key,
    required this.itemModel,
    required this.onCheckboxChanged,
  }) : super(key: key);

  final ItemModelToDoList itemModel;

  final ValueChanged<bool> onCheckboxChanged;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  void toggleButton() {
    setState(() {
      widget.itemModel.isChecked = !widget.itemModel.isChecked;
    });
    widget.onCheckboxChanged(widget.itemModel.isChecked);
    context.read<ToDoListCubit>().updateTask(widget.itemModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleButton();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.itemModel.isChecked ? Colors.grey : Colors.amber,
          borderRadius: BorderRadius.circular(10), // Zaokrąglenie kontenera
          border: Border.all(
            color: const Color.fromARGB(255, 67, 64, 64),
            width: 3,
          ),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.itemModel.title,
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: widget.itemModel.isChecked ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(255, 67, 64, 64), // Kolor ramki
                  width: 3, // Grubość ramki
                ),
              ),
              child: widget.itemModel.isChecked
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
