import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/screens/navigation/nutrition_page.dart';
import 'package:neurofit_app/screens/navigation/workout_page.dart';
import 'package:neurofit_app/screens/navigation_screen.dart';
import 'package:neurofit_app/widgets.dart';
import 'package:neurofit_app/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gradient_progress_bar/gradient_progress_bar.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'welcomeTitle',
                    child: Text(
                      'NeuroFit',
                      style: kAppName,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('setting');
                    },
                    child: Icon(Icons.settings, color: kBlue, size: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
              child: Text(
                'Good Morning, Jorge 👋',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Text(
              'Lets make today your healthiest yet!',
              style: TextStyle(
                color: kBlack,
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: 872 / 1200,
                    radius: 120,
                    lineWidth: 16,
                    linearGradient: LinearGradient(
                      colors: [
                        Color(0xFFF97316),
                        Color(0xFFFACC15),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: 60 / 120, // Exercise
                    radius: 100,
                    lineWidth: 16,
                    linearGradient: LinearGradient(
                      colors: [
                        Color(0xFF06B6D4),
                        Color(0xFF3B82F6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: 6 / 7,
                    radius: 80,
                    lineWidth: 16,
                    linearGradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 130, 149, 245),
                        Color.fromARGB(255, 185, 169, 248),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("876",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Text("cal", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GoalCard(
                    goal: 'Move',
                    progress: '876/1200',
                    unit: 'cal',
                    icon: Icons.local_fire_department),
                GoalCard(
                    goal: 'Excercise',
                    progress: '60/120',
                    unit: 'min',
                    icon: Icons.directions_run),
                GoalCard(
                    goal: 'Stand',
                    progress: '3/7',
                    unit: 'hr',
                    icon: Icons.access_time),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.goal,
    required this.progress,
    required this.unit,
    required this.icon,
  });

  final String goal;
  final String progress;
  final String unit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: kWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: goal == 'Move'
                        ? Color(0xFFF97316)
                        : goal == 'Excercise'
                            ? Color(0xFF06B6D4)
                            : Color.fromARGB(255, 130, 149, 245),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(goal),
                ],
              ),
            ),
            Text(
              progress,
              style: TextStyle(
                  color: kBlack, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              unit,
              style: TextStyle(color: Colors.grey[600], fontSize: 10),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
