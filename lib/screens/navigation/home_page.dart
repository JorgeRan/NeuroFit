import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        Color.fromARGB(255, 245, 154, 89),
                        Color.fromARGB(255, 251, 217, 82),
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
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 15),
              color: kWhite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14, right: 8),
                            child: Icon(
                              Icons.tips_and_updates_rounded,
                              color: kBlue,
                              size: 40,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NeuroFit Suggest...',
                                  style: TextStyle(
                                    color: kBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Try a 20-minute walk in the afternoon to boost your focus.',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Goal progress');
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Goal Progress',
                                  style: TextStyle(
                                    color: kBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey[600],
                                  size: 20,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Strength Training',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    borderRadius: BorderRadius.circular(12),
                                    value: 0.75,
                                    backgroundColor: kFieldBorder,
                                    color: kBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '75%',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Protein Intake',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    borderRadius: BorderRadius.circular(12),
                                    value: 0.40,
                                    backgroundColor: kFieldBorder,
                                    color: kBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '40%',
                                  style:
                                      TextStyle(color: kTextGrey, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Today\'s Plan', style: kTitleCard),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey[600],
                              size: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 120, // Or any height that fits your content
                          child: Row(
                            children: [
                              // Left section
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 8),
                                      child: Icon(
                                        Icons.fitness_center,
                                        color: kBlue,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Workout',
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '30 min core stability',
                                            style: TextStyle(fontSize: 17),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              VerticalDivider(
                                color: Colors.grey,
                                thickness: 0.5,
                                width: 1,
                                indent: 18,
                                endIndent: 18,
                              ),

                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 8),
                                      child: Icon(
                                        Icons.restaurant,
                                        color: kBlue,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Nutrition',
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'Keep dinner under 500 cal',
                                            style: TextStyle(fontSize: 17),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Recent Activity', style: kTitleCard),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        RecentActivity(
                          label: 'Running',
                          time: '45 min',
                          calories: '425 cal',
                          date: 'Today',
                        ),
                        Divider(
                            color: Colors.grey[200],
                          ),

                        RecentActivity(
                          label: 'Strength',
                          time: '30 min',
                          calories: '285 cal',
                          date: 'Yesterday',
                        ),
                        Divider(
                            color: Colors.grey[200],
                          ),
                        RecentActivity(
                          label: 'Cycling',
                          time: '60 min',
                          calories: '534 cal',
                          date: '2 days ago',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Wellness Summary:',
              style: kTitleCard,
            ),
            SizedBox(
              height: 5,
            ),
            SummaryRow(
              label: 'Sleep: ',
              value: '7h 30m',
              icon: Icons.bedtime,
            ),
            SummaryRow(
              label: 'Hydration: ',
              value: '68%',
              icon: Icons.water_drop,
            ),
            SummaryRow(
              label: 'Resting HR: ',
              value: '57 bpm',
              icon: Icons.favorite,
            ),
            SummaryRow(
              label: 'Calories Burned: ',
              value: '876 cal',
              icon: Icons.local_fire_department,
            ),
            SummaryRow(
              label: 'Steps: ',
              value: '6,300',
              icon: Icons.directions_walk,
            ),
            SummaryRow(
              label: 'Active Minutes: ',
              value: '32 min',
              icon: Icons.timer,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Log Shortcuts',
              style: kTitleCard,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogButtons(
                    label: 'Log Workout',
                    icon: Icon(
                      Icons.fitness_center,
                      color: kWhite,
                      size: 28,
                    ),
                    onTap: () {
                      print('workout logged');
                    },
                  ),
                  LogButtons(
                      label: 'Log Meal',
                      icon: Icon(
                        Icons.restaurant,
                        color: kWhite,
                        size: 28,
                      ),
                      onTap: () {
                        print('meal logged');
                      }),
                  LogButtons(
                    label: 'Log Sleep',
                    onTap: () {
                      print('sleep logged');
                    },
                    icon: Image.asset(
                      'assets/images/sleep_white.png',
                      width: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivity extends StatelessWidget {
  const RecentActivity({
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: kBlack, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '$time · $calories',
                style: TextStyle(
                  color: kTextGrey,
                  fontSize: 17,
                ),
              )
            ],
          ),
          Text(
            date,
            style: TextStyle(
              color: kTextGrey,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

class LogButtons extends StatelessWidget {
  const LogButtons({
    super.key,
    required this.label,
    required this.onTap,
    required this.icon,
  });

  final String label;
  final Function onTap;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            backgroundColor: kBlue,
          ),
          onPressed: () => onTap,
          child: icon,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
  });
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2563EB), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 16)),
          ),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
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
