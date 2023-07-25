import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/data/remote_data_sources/tasks_remote_data_sources.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_cubit.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

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
      create: (context) =>
          getIt<ToDoListCubit>()..start(),
      child: BlocListener<ToDoListCubit, ToDoListState>(
        listener: (context, state) {
          if (state.saved) {
            context.read<ToDoListCubit>().start();
          }
          final errorMessage = state.errorMessage ?? 'Unknown error';
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.status == Status.loading) {
            const Center(
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
                  style: GoogleFonts.buenard(
                      fontSize: 22,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.black87,
                actions: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo[700]),
                    ),
                    icon: Icon(Icons.add, color: Colors.yellow[400]),
                    label: Text(
                      'Dodaj zadanie',
                      style: GoogleFonts.buenard(
                          fontSize: 20,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    "Wprowadź jakieś zdanie!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
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
                color: Colors.black87,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        style: GoogleFonts.buenard(
                            fontSize: 20,
                            color: Colors.yellow[400],
                            fontWeight: FontWeight.bold),
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 238, 88, 1),
                                width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 67, 64, 64),
                                width: 2.0),
                          ),
                          hintText: 'Tu wpisz nazwę zadania',
                          hintStyle: GoogleFonts.buenard(
                            fontSize: 20,
                            color: Colors.yellow[400],
                          ),
                        ),
                      ),
                    ),
                    for (var itemModel in itemModels) ...[
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
                              itemModel = itemModel.copyWith(isChecked: value);
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

  ItemModelToDoList itemModel;

  final ValueChanged<bool> onCheckboxChanged;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  void toggleButton() {
    setState(() {
      widget.itemModel =
          widget.itemModel.copyWith(isChecked: !widget.itemModel.isChecked);
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
          color: widget.itemModel.isChecked ? Colors.grey : Colors.indigo[700],
          borderRadius: BorderRadius.circular(10),
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
            Expanded(
              child: Text(
                widget.itemModel.title,
                style: GoogleFonts.buenard(
                    fontSize: 20,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
              ),
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
