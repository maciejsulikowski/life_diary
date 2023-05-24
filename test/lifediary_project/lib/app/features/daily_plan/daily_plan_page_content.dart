import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart';

class DailyPlanPageContent extends StatefulWidget {
  DailyPlanPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyPlanPageContent> createState() => _DailyPlanPageContentState();
}

class _DailyPlanPageContentState extends State<DailyPlanPageContent> {
  late String id;
  late List<TextEditingController> controllers;
  late final String time;
  var controller = TextEditingController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyPlanCubit(PlansRepository())..start(),
      child: BlocListener<DailyPlanCubit, DailyPlanState>(
        listener: (context, state) {
          if (state.saved) {
            context.read<DailyPlanCubit>().start();
          }
        },
        child: BlocBuilder<DailyPlanCubit, DailyPlanState>(
          builder: (context, state) {
            final dailyPlanModels = state.list;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'PLAN DNIA',
                  style: GoogleFonts.buenard(
                      fontSize: 22,
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.black87,
              ),
              body: DailyPlanBody(
                dailyPlanModels: dailyPlanModels,
              ),
            );
          },
        ),
      ),
    );
  }
}

class DailyPlanBody extends StatelessWidget {
  DailyPlanBody({
    required this.dailyPlanModels,
    Key? key,
  }) : super(key: key);

  List<DailyPlanModel> dailyPlanModels;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: ListView(
        children: [
          for (var index = 0; index < 19; index++) ...[
            Builder(builder: (context) {
              final currentHour = 600 + index * 100;
              final itemModel = dailyPlanModels.firstWhereOrNull(
                  (item) => item.time == currentHour.toString());

              return MyListTileItemWidget(
                currentHour: currentHour,
                itemModel: itemModel,
              );
            }),
          ],
        ],
      ),
    );
  }
}

class MyListTileItemWidget extends StatefulWidget {
  MyListTileItemWidget(
      {super.key, required this.currentHour, required this.itemModel});

  final int currentHour;
  final DailyPlanModel? itemModel;

  @override
  State<MyListTileItemWidget> createState() => _MyListTileItemWidgetState();
}

class _MyListTileItemWidgetState extends State<MyListTileItemWidget> {
  late String text;
  late TextEditingController controller;

  @override
  void initState() {
    text = widget.itemModel?.text ?? '';
    controller = TextEditingController(text: text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            TimeContainer(
              currentHour: widget.currentHour,
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              PartOfPlanning(
                controller: controller =
                    TextEditingController(text: widget.itemModel?.text),
              ),
              Positioned(
                top: 30,
                right: 5,
                child: Container(
                  width: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black87),
                    onPressed: () {
                      context.read<DailyPlanCubit>().addplan(
                            controller.text,
                            widget.currentHour.toString(),
                          );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        '✓',
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
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
    final hourString = currentHour.toString().padLeft(4, '0');
    final formattedHourString =
        '${hourString.substring(0, 2)}:${hourString.substring(2)}';
    return Container(
        width: 80,
        height: 95,
        color: Colors.yellow[400],
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            '${(formattedHourString)}',
            style: GoogleFonts.buenard(
                fontSize: 16,
                color: Colors.indigo[700],
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class PartOfPlanning extends StatelessWidget {
  const PartOfPlanning({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      color: Colors.indigo[700],
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        style: GoogleFonts.buenard(
            fontSize: 24,
            color: Colors.yellow[400],
            fontWeight: FontWeight.bold),
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Wpisz swój plan tutaj.. ',
          hintStyle: GoogleFonts.buenard(
              fontSize: 20,
              color: Colors.yellow[400],
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
