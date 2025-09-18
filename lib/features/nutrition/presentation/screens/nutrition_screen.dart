import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/nutrition/presentation/views/create_food_MBS.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class NutritionPage extends ConsumerWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[kNutriitonPageColor, kLightGrey]),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: kBlack,
                    size: 30,
                  ),
                  onPressed: () {
                    print('Settings');
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'Nutrition',
              //         style: kScreenTitle,
              //         textAlign: TextAlign.start,
              //       ),
              //       Text(
              //         'NeuroFit',
              //         style: kAppName,
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text(
                  'Complete your daily\nnutrition 🥗',
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    NutritionMealCard(label: 'Breakfast', calories: '456'),
                    NutritionMealCard(
                      label: 'Lunch',
                      calories: '500',
                    ),
                    NutritionMealCard(label: 'Dinner', calories: '300'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  color: kWhite,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Summary',
                              style: kTitleCard.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Remaining\n',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 142, 142, 142),
                                            fontSize: 15),
                                      ),
                                      TextSpan(
                                          text: '564',
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Target\n',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 142, 142, 142),
                                            fontSize: 15),
                                      ),
                                      TextSpan(
                                          text: '1120',
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                            CircularProgressNutrition(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MacroProgressWidget(
                              label: "Protein",
                              current: 42,
                              total: 77,
                              color: Colors.orange,
                            ),
                            MacroProgressWidget(
                              label: "Carbs",
                              current: 85,
                              total: 136,
                              color: Colors.blue,
                            ),
                            MacroProgressWidget(
                              label: "Fat",
                              current: 20,
                              total: 40,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NutritionDashboardButtons(
                    label: 'Food Log',
                    onTap: () {
                      print('Food Log');
                    },
                  ),
                  NutritionDashboardButtons(
                    label: 'Plans',
                    onTap: () {
                      print('Plans');
                    },
                  ),
                  NutritionDashboardButtons(
                    label: 'Create Food',
                    onTap: () {
                      createFoodMBS(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NutritionDashboardButtons extends StatelessWidget {
  const NutritionDashboardButtons({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          boxShadow: kContainerElevation,
          borderRadius: BorderRadius.circular(10),
          color: label == 'Food Log'
              ? Color(0xFFE0ECFB)
              : label == 'Plans'
                  ? Color(0xFFE0ECFB)
                  : Color(0xFFE0ECFB),
        ),
        height: MediaQuery.of(context).size.width * 0.2,
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              label == 'Food Log'
                  ? Icons.auto_stories_outlined
                  : label == 'Plans'
                      ? Icons.checklist_outlined
                      : Icons.food_bank,
              size: 30,
              color: kBlue,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionMealCard extends StatelessWidget {
  const NutritionMealCard({
    required this.label,
    required this.calories,
    super.key,
  });

  final String label;

  final String calories;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 110,
      margin: const EdgeInsets.all(8.0),
      child: Card(
        color: label == 'Breakfast'
            ? kBreakfastColorCard
            : label == 'Lunch'
                ? kLunchColorCard
                : kDinnerColorCard,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(128, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05), // light shadow
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3), // subtle downward shift
                        ),
                      ],
                    ),
                    child: Icon(
                      label == 'Breakfast'
                          ? Icons.wb_twilight_outlined
                          : label == 'Lunch'
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                      size: 15,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: calories,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                    ),
                    TextSpan(text: "  cal", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularProgressNutrition extends StatelessWidget {
  const CircularProgressNutrition({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularPercentIndicator(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        animation: true,
        animationDuration: 1000,
        circularStrokeCap: CircularStrokeCap.round,
        percent: 872 / 1200,
        radius: 120,
        lineWidth: 18,
        linearGradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 245, 154, 89),
            Color.fromARGB(255, 251, 217, 82),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        center: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: kWhite,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 255, 217, 190),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange, size: 28),
              SizedBox(height: 6),
              Text(
                "656",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                "Consumed",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MacroProgressWidget extends StatelessWidget {
  final String label;
  final int current;
  final int total;
  final Color color;

  const MacroProgressWidget({
    required this.label,
    required this.current,
    required this.total,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double percent = current / total;

    return Row(
      children: [
        CircularPercentIndicator(
          radius: 22.0,
          lineWidth: 7.0,
          percent: percent.clamp(0.0, 1.0),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey.shade200,
          progressColor: color,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: const Color.fromARGB(255, 79, 79, 79),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$current',
                    style: TextStyle(color: kBlack, fontSize: 17),
                  ),
                  TextSpan(
                    text: '/${total}g',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            // Text(
            //   "$current / ${total}g",
            //   style: TextStyle(color: Colors.grey[600], fontSize: 14),
            // ),
          ],
        ),
      ],
    );
  }
}
