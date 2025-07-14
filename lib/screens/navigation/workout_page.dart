import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/interactive_body.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:neurofit_app/graphs.dart';

final showAvgProvider = StateProvider<bool>((ref) => false);

class WorkoutPage extends ConsumerWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFront = ref.watch(isFrontProvider);

    bool showAvg = ref.watch(showAvgProvider);

    return Container(
      color: kWorkoutPageColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Workouts',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Hero(
                      tag: 'welcomeTitle',
                      child: Text(
                        'NeuroFit',
                        style: kAppName,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                color: kWhite,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.show_chart,
                            color: kBlue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Weekly Progress', style: kTitleCard),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '3 of 5 workouts',
                            style: TextStyle(color: kTextGrey, fontSize: 15),
                          ),
                          Text(
                            '60%',
                            style: TextStyle(
                                color: kBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      LinearProgressIndicator(
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(12),
                        value: 0.60,
                        backgroundColor: kFieldBorder,
                        color: kBlue,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: kBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWorkoutPageColor,
                            ),
                            child: const Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xFF3B82F6),
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Routines',
                                style: kTitleCard.copyWith(color: kWhite),
                              ),
                              const Text(
                                '8 Routines',
                                style: TextStyle(color: kWhite, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kWhite,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWorkoutPageColor,
                            ),
                            child: const Icon(
                              Icons.directions_run_rounded,
                              color: Color(0xFF3B82F6),
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Workouts',
                                style: kTitleCard.copyWith(color: kWhite),
                              ),
                              const Text(
                                '11 Wourkouts',
                                style: TextStyle(color: kWhite, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kWhite,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Tap a Muscle to Discover Exercises',
                  style: kTitleCard.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    ref.read(isFrontProvider.notifier).state = !isFront,
                child: Text(isFront ? 'Show Back' : 'Show Front'),
              ),
              // FIXED HEIGHT CONTAINER
              InteractiveBody(isFront: isFront),
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.only(bottom: 15),
                color: kWhite,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: GestureDetector(
                    onTap: () {
                      print('Goal progress');
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recent Workouts', style: kTitleCard),
                          SizedBox(
                            height: 15,
                          ),
                          RecentWorkout(
                            label: 'Upper Body Strength',
                            time: '45 min',
                            calories: '425 cal',
                            date: 'Today',
                          ),
                          Divider(
                            color: Colors.grey[200],
                          ),
                          RecentWorkout(
                            label: 'HIIT Cardio',
                            time: '30 min',
                            calories: '285 cal',
                            date: 'Yesterday',
                          ),
                          Divider(
                            color: Colors.grey[200],
                          ),
                          RecentWorkout(
                            label: 'Leg Day',
                            time: '60 min',
                            calories: '534 cal',
                            date: '2 days ago',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'View all workouts ',
                                style: TextStyle(
                                    color: kBlue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: kBlue,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 15),
                color: kWhite,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: GestureDetector(
                    onTap: () {
                      print('Goal progress');
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.psychology_rounded,
                                size: 30,
                                color: kBlue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('AI Suggestions', style: kTitleCard),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          AiSuggestion(
                            label: 'Recovery Walk',
                            text:
                                'Based on your intense workout yesterday, a light recovery walk would be ideal today.',
                            emogi: '🚶‍♂️',
                          ),
                          AiSuggestion(
                            label: 'Upper Body Strength',
                            text:
                                'You\'ve been working you lower body a lot. Time to balance with some upper body excercises.',
                            emogi: '💪',
                          ),
                          AiSuggestion(
                            label: 'Try a new HIIT Routine',
                            text:
                                'Your fitness level has improved. Ready for a more challenging HIIT session?',
                            emogi: '🔥',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              DefaultTabController(
                length: 3,
                initialIndex: 1,
                child: Card(
                  margin: EdgeInsets.only(bottom: 15),
                  color: kWhite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bar_chart_rounded,
                              size: 30,
                              color: kBlue,
                            ),
                            SizedBox(width: 5),
                            Text('Workout Stats', style: kTitleCard),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TabBar(
                          labelColor: kBlue,
                          indicatorColor: kBlue,
                          labelStyle: TextStyle(fontSize: 17),
                          tabs: const [
                            Tab(text: 'Frequency'),
                            Tab(text: 'Calories'),
                            Tab(text: 'Milestones'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 250, // adjust based on your content
                          child: TabBarView(
                            children: [
                              BarChartWidget(),
                              LineChartWidget(showAvg: showAvg),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Workouts Completed',
                                            style: TextStyle(
                                                color: kBlack, fontSize: 16),
                                          ),
                                          Text(
                                            '60%',
                                            style: TextStyle(
                                                color: kBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      LinearProgressIndicator(
                                        minHeight: 10,
                                        borderRadius: BorderRadius.circular(12),
                                        value: 0.60,
                                        backgroundColor: kFieldBorder,
                                        color: kBlue,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '5 Different Workout types',
                                            style: TextStyle(
                                                color: kBlack, fontSize: 16),
                                          ),
                                          Text(
                                            '60%',
                                            style: TextStyle(
                                                color: kBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      LinearProgressIndicator(
                                        minHeight: 10,
                                        borderRadius: BorderRadius.circular(12),
                                        value: 0.60,
                                        backgroundColor: kFieldBorder,
                                        color: kBlue,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Workout Streak: 3 Days',
                                                style: TextStyle(
                                                    color: kBlack,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                '60%',
                                                style: TextStyle(
                                                    color: kBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          LinearProgressIndicator(
                                            minHeight: 10,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            value: 0.60,
                                            backgroundColor: kFieldBorder,
                                            color: kBlue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartWidget extends ConsumerWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late int showingTooltip = -1;

    BarChartGroupData generateGroupData(int x, int y) {
      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y.toDouble(),
            color: kBlue,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }

    final List<String> xLabels = [
      'Week 1',
      'Week 2',
      'Week 3',
      'Week 4',
    ];

    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 32,
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        (index >= 0 && index < xLabels.length)
                            ? xLabels[index]
                            : '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
                show: true,
                border: Border(
                    right: BorderSide.none,
                    left: BorderSide(),
                    bottom: BorderSide())),
            barGroups: [
              generateGroupData(0, 1),
              generateGroupData(1, 2),
              generateGroupData(2, 0),
              generateGroupData(3, 1),
              
            ],
            barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback: (event, response) {
                  if (response != null &&
                      response.spot != null &&
                      event is FlTapUpEvent) {
                    final x = response.spot!.touchedBarGroup.x;
                    final isShowing = showingTooltip == x;
                    if (isShowing) {
                      showingTooltip = -1;
                    } else {
                      showingTooltip = x;
                    }
                  }
                },
                mouseCursorResolver: (event, response) {
                  return response == null || response.spot == null
                      ? MouseCursor.defer
                      : SystemMouseCursors.click;
                }),
          ),
        ),
      ),
    );
  }
}

class LineChartWidget extends ConsumerWidget {
  const LineChartWidget({
    super.key,
    required this.showAvg,
  });

  final bool showAvg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              ref.read(showAvgProvider.notifier).state = !showAvg;
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? kBlack.withAlpha(125) : kBlack,
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: LineChart(showAvg ? avgData() : mainData()),
          ),
        ),
      ],
    );
  }
}

class RecentWorkout extends StatelessWidget {
  const RecentWorkout({
    super.key,
    required this.label,
    required this.time,
    required this.calories,
    required this.date,
  });

  final String label;
  final String time;
  final String calories;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: kBlack, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(
                    Icons.repeat_rounded,
                    color: kBlue,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Repeat',
                    style: TextStyle(color: kBlue, fontSize: 17),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              date,
              style: TextStyle(
                color: kTextGrey,
                fontSize: 17,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: kTextGrey,
              ),
              Text(
                ' $time',
                style: TextStyle(
                  color: kTextGrey,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.local_fire_department,
                color: kTextGrey,
              ),
              Text(
                ' $calories',
                style: TextStyle(
                  color: kTextGrey,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kWorkoutPageColor),
                child: Text(
                  'Chest',
                  style: TextStyle(color: kBlue, fontSize: 17),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kWorkoutPageColor),
                child: Text(
                  'Back',
                  style: TextStyle(color: kBlue, fontSize: 17),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kWorkoutPageColor),
                child: Text(
                  'Arms',
                  style: TextStyle(color: kBlue, fontSize: 17),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AiSuggestion extends StatelessWidget {
  const AiSuggestion({
    super.key,
    required this.label,
    required this.text,
    required this.emogi,
  });

  final String label;
  final String text;
  final String emogi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              color: Colors.blue, // your desired color
              width: 4, // thickness of the left border
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emogi,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                            color: kBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Try this ',
                  style: TextStyle(
                      color: kBlue, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: kBlue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
