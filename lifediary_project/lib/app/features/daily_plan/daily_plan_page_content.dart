import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_state.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DailyPlanPageContent extends StatefulWidget {
  const DailyPlanPageContent({
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
      create: (context) => getIt<DailyPlanCubit>()..start(),
      child: BlocListener<DailyPlanCubit, DailyPlanState>(
        listener: (context, state) {
          if (state.isSaved) {
            context.read<DailyPlanCubit>().start();
          }
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unknown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<DailyPlanCubit, DailyPlanState>(
          builder: (context, state) {
            final dailyPlanModels = state.list;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.dayplan,
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

// ignore: must_be_immutable
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
  const MyListTileItemWidget(
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
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TimeContainer(
            currentHour: widget.currentHour,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                PartOfPlanning(
                  controller: controller =
                      TextEditingController(text: widget.itemModel?.text),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      context.read<DailyPlanCubit>().addplan(
                            controller.text,
                            widget.currentHour.toString(),
                          );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '✓',
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
    final hourString = currentHour.toString().padLeft(4, '0');
    final formattedHourString =
        '${hourString.substring(0, 2)}:${hourString.substring(2)}';
    return Container(
        width: 100,
        height: 100,
        color: Colors.yellow[400],
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            (formattedHourString),
            style: GoogleFonts.buenard(
                fontSize: 18,
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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        style: GoogleFonts.buenard(
          fontSize: 24,
          color: Colors.yellow[400],
          fontWeight: FontWeight.bold,
        ),
        controller: controller,
        maxLines: null, // Pozwala na dowolną liczbę linii
        keyboardType:
            TextInputType.multiline, // Pozwala na wpisywanie w wielu liniach
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction
            .newline, // Włącza przycisk nowej linii na klawiaturze
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.dayplan_text,
          hintStyle: GoogleFonts.buenard(
            fontSize: 20,
            color: Colors.yellow[400],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
