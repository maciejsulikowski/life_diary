import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/home/daily_plan/cubit/daily_plan_cubit.dart';
import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';

class DailyPlanPageContent extends StatefulWidget {
  DailyPlanPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyPlanPageContent> createState() => _DailyPlanPageContentState();
}

class _DailyPlanPageContentState extends State<DailyPlanPageContent> {
  final List<TextEditingController> controllers =
      List.generate(19, (i) => TextEditingController());

  var controller = TextEditingController();
  int index = 0;
  @override
  void initState() {
    super.initState();
    controller = controllers[index];
    index++;
  }

  int currentHour = 6;
  int newHour = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyPlanCubit(ItemsRepository()),
      child: BlocListener<DailyPlanCubit, DailyPlanState>(
        listener: (context, state) {
          if (state.saved) {
            context.read<DailyPlanCubit>().start();
          }
        },
        child: BlocBuilder<DailyPlanCubit, DailyPlanState>(
          builder: (context, state) {
            final dailyPlanModel = state.list;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'PLAN DNIA',
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
                  context.read<DailyPlanCubit>().addplan(controller.text);
                  setState(() {
                    controller = controllers[index];
                    index++;
                  });
                },
                child: const Icon(Icons.add),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 80,
                    maxWidth: 400,
                  ),
                  child: ListView(
                    children: [
                      for (var index = 0;
                          index < controllers.length;
                          index++) ...[
                        Row(
                          children: [
                            Column(
                              children: [
                                TimeContainer(
                                  currentHour: currentHour + index,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  PartOfPlanning(
                                    controllers: controllers,
                                    index: index,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    required this.currentHour,
    Key? key,
  }) : super(key: key);

  final int currentHour;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 88,
        color: Colors.green,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        child: Text('$currentHour:00'));
  }
}

class PartOfPlanning extends StatefulWidget {
  PartOfPlanning({
    required this.index,
    required this.controllers,
    Key? key,
  }) : super(key: key);

  final List<TextEditingController> controllers;
  // final TextEditingController controller = TextEditingController();
  final int index;

  @override
  State<PartOfPlanning> createState() => _PartOfPlanningState();
}

class _PartOfPlanningState extends State<PartOfPlanning> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: widget.controllers[widget.index],
        onChanged: (value) {
          // final dailyPlanCubit = context.read<DailyPlanCubit>();
          // dailyPlanCubit.updateplan(value, widget.index);
        },
        decoration: InputDecoration(
          hintText: 'Wpisz swój plan tutaj.. ',
        ),
      ),
    );
  }
}
