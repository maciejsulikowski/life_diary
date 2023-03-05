import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
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
  late String id;
  late List<TextEditingController> controllers;
  late final String time;
  var controller = TextEditingController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyPlanCubit(ItemsRepository())..start(),
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
                  style: GoogleFonts.lato(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.blue,
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
    // required this.id,
    required this.dailyPlanModels,
    Key? key,
  }) : super(key: key);
  // late String id;
  List<DailyPlanModel> dailyPlanModels;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 80,
        maxWidth: 400,
      ),
      child: ListView(
        children: [
          for (var index = 0; index < 19; index++) ...[
            Builder(builder: (context) {
              final currentHour = 600 + index * 100;
              final itemModel = dailyPlanModels.firstWhereOrNull(
                  (item) => item.time == currentHour.toString());
              final hourString = currentHour.toString().padLeft(4, '0');
              final formattedHourString =
                  '${hourString.substring(0, 2)}:${hourString.substring(2)}';
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

  // final String id;
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
          child: Column(
            children: [
              PartOfPlanning(
                controller: controller =
                    TextEditingController(text: widget.itemModel?.text),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // text = widget.itemModel?.text ?? '';
            context.read<DailyPlanCubit>().addplan(
                  controller.text,
                  widget.currentHour.toString(),
                ); //widget.itemModel.id
          },
          child: Text('+'),
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
        height: 88,
        color: Colors.green,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        child: Text('${(formattedHourString)}'));
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
      width: 300,
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Wpisz swój plan tutaj.. ',
        ),
      ),
    );
  }
}
