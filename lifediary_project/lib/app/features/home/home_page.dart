import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/features/daily_plan/daily_plan_page_content.dart';
import 'package:lifediary_project/app/features/diaries/diaries_page_content.dart';
import 'package:lifediary_project/app/features/my_account/my_account_page_content.dart';
import 'package:lifediary_project/app/features/to_do_list/to_do_list_content.dart';
import 'package:lifediary_project/app/features/training/training_page_content.dart';
import 'package:lifediary_project/app/features/water/water_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return MyAccountPageContent(
            email: widget.user.email,
          );
        }
        if (currentIndex == 1) {
          return const DiariesPageContent();
        }
        if (currentIndex == 2) {
          return const Center(
            child: TrainingPageContent(),
          );
        }
        if (currentIndex == 3) {
          return const Center(child: WaterPage());
        }
        if (currentIndex == 4) {
          return const ToDoListContent();
        }
        if (currentIndex == 5) {
          return const Center(
            child: DailyPlanPageContent(),
          );
        }
        return MyAccountPageContent(
          email: widget.user.email,
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow[400],
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          }); //ss
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.person,
            ),
            icon: const Icon(
              Icons.person,
            ),
            label: AppLocalizations.of(context)!.bottombar1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: AppLocalizations.of(context)!.bottombar2,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sports_martial_arts_sharp),
            label: AppLocalizations.of(context)!.bottombar3,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.water_drop),
            label: AppLocalizations.of(context)!.bottombar4,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'ToDoList',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.lock_clock),
            label: AppLocalizations.of(context)!.bottombar5,
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
