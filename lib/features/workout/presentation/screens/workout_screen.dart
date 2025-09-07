import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';
import 'package:neurofit_app/features/workout/presentation/screens/start_workout_screen.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({
    required this.workout,
    super.key,
  });

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new,
                          color: kBlack, size: 24),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Edit workout');
                      },
                      child: Row(
                        children: [
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 18,
                              color: kTextGrey,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Image.asset('assets/icons/Edit_icon.png', width: 25,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBlue,
                  boxShadow: kContainerElevation,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                        child: Text(
                          workout.name,
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: workout.targetMuscle
                            .map(
                              (muscle) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                  color: kCardBlue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(muscle,
                                    style: TextStyle(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            )
                            .toList(),
                      ),
                      Image.asset('assets/images/muscles_worked.png'),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  boxShadow: kContainerElevation,
                ),
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WorkoutInfoItem(
                      icon: Icons.access_time,
                      value: '${workout.duration} min',
                      label: 'Duration',
                    ),
                    WorkoutInfoItem(
                      icon: Icons.fitness_center_rounded,
                      value: '${workout.exercises.length}',
                      label: 'Exercises',
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  boxShadow: kContainerElevation,
                ),
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: kQuestionsText,
                    ),
                    Text(
                      workout.description,
                      style: kParagraphText,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: kContainerElevation,
                  color: kWhite,
                ),
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exercises',
                      style: kQuestionsText,
                    ),
                    Column(
                      children: workout.exercises
                          .map((exercises) => Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: workout.exercises
                                                    .indexOf(exercises) ==
                                                0
                                            ? Colors.transparent
                                            : kFieldBorder),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.asset(
                                            'assets/images/Upper Body.png',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${workout.exercises.indexOf(exercises) + 1}. ${exercises.name}',
                                              style: kQuestionsText,
                                            ),
                                            Text(
                                              '${exercises.sets.length} sets',
                                              style:
                                                  TextStyle(color: kTextGrey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      exercises.equipment,
                                      style: TextStyle(
                                          color: kTextGrey, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kWhite,
        elevation: 8,
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: kBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                print('Start Workout');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartWorkoutScreen(
                      workout: workout,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: MediaQuery.of(context).size.width * 0.3),
                child: Text(
                  'Start Workout',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutInfoItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const WorkoutInfoItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kTextGrey,
          size: 27,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(label, style: const TextStyle(color: kTextGrey, fontSize: 15)),
          ],
        ),
      ],
    );
  }
}
