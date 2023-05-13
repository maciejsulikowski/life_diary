import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';

import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';

class WaterPage extends StatefulWidget {
  WaterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WaterPage> createState() => WaterPageState();
}

class WaterPageState extends State<WaterPage> {
  final heightController = TextEditingController();

  final weightController = TextEditingController();

  var result = 0;
  var glass_result = 0;
  var glass = 330;

  var isAnswered = false;
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WaterCubit(ItemsRepository()),
      child: BlocBuilder<WaterCubit, WaterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'WODA',
                style: GoogleFonts.lato(
                    color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/water.jpg"), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Ile szklanek wody powinieneś pić dziennie?',
                        style: GoogleFonts.lato(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: heightController,
                      style: const TextStyle(color: Colors.amber, fontSize: 20),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.blue,
                        border: OutlineInputBorder(),
                        hintText: 'Tutaj napisz swój wzrost w cm np. 180',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: weightController,
                      style: const TextStyle(color: Colors.amber, fontSize: 20),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.blue,
                        border: OutlineInputBorder(),
                        hintText: 'Tutaj napisz swoją wagę w kg np. 80',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (heightController.text.isEmpty ||
                          weightController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Wprowadź wszystkie dane!"),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        isAnswered = true;
                        result =
                            (30 * double.parse(weightController.text)).toInt();
                        glass_result = (result / glass).floor();
                        answer = glass_result.toString();
                        context.read<WaterCubit>().saveGlasses(answer);
                      });
                    },
                    child: Text(
                      'Oblicz!',
                      style: TextStyle(color: Colors.amber, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (isAnswered == true) ...[
                    Center(
                      child: Text(
                        'Powinieneś pić około $result ml wody!',
                        style: GoogleFonts.lato(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Co daje gdzieś $glass_result szklanek wody dziennie!',
                        style: GoogleFonts.lato(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
