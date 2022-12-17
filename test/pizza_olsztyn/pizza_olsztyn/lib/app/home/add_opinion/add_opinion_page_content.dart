import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var pizzaName = '';
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Podaj nazwe restauracji",
            ),
            onChanged: (newValue) {
              setState(() {
                restaurantName = newValue;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Podaj nazwe pizzy",
            ),
            onChanged: (newValue) {
              setState(() {
                pizzaName = newValue;
              });
            },
          ),
          Slider(
            onChanged: (newValue) {
              setState(() {
                rating = newValue;
              });
            },
            value: rating,
            min: 1.0,
            max: 6.0,
            divisions: 10,
            label: rating.toString(),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('restaurants').add({
                'name': restaurantName,
                'pizza': pizzaName,
                'rating': rating,
              });
            },
            child: Text("Dodaj"),
          ),
        ],
      ),
    );
  }
}
