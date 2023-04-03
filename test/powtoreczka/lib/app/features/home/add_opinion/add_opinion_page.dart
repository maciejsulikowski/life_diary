import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:powtoreczka/app/features/home/add_opinion/cubit/add_cubit.dart';
import 'package:powtoreczka/app/models/item_model.dart';
import 'package:powtoreczka/app/repositories/items_repository.dart';

class AddingPage extends StatefulWidget {
  const AddingPage({
    super.key,
    required this.onSave,
  });

  final Function onSave;

  @override
  State<AddingPage> createState() => AddingPageState();
}

class AddingPageState extends State<AddingPage> {
  late final Function onDataChanged;
  var restaurantName = '';
  var pizzaName = '';
  var rating = 3.0;
  var releaseDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(
        ItemsRepository(),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      Duration(
                        days: 365 * 10,
                      ),
                    ),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      releaseDate = selectedDate;
                    });
                  }
                },
                child: Text(
                  releaseDate == null
                      ? 'Podaj datę'
                      : DateFormat.MMMEd().format(releaseDate),
                ),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Podaj restauracje'),
                onChanged: (newValue) {
                  setState(() {
                    restaurantName = newValue;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Podaj pizze'),
                onChanged: (newValue) {
                  setState(() {
                    pizzaName = newValue;
                  });
                },
              ),
              Slider(
                value: rating,
                min: 1.0,
                max: 6.0,
                divisions: 10,
                label: rating.toString(),
                onChanged: (newValue) {
                  setState(() {
                    rating = newValue;
                  });
                },
              ),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: restaurantName.isEmpty ||
                          pizzaName.isEmpty ||
                          releaseDate == null
                      ? null
                      : () {
                          context.read<AddCubit>().addPizza(
                              restaurantName, pizzaName, rating, releaseDate);
                          widget.onSave();
                        },
                  child: Text('Dodaj'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
