import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/logic/models/routine_model.dart';
import 'package:neurofit_app/features/workout/presentation/screens/start_workout_screen.dart';
import 'package:neurofit_app/features/workout/presentation/sheets/workouts_sheet.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

class RoutineScreen extends ConsumerWidget {
  const RoutineScreen({
    required this.routine,
    required this.workoutCount,
    super.key,
  });

  final RoutineModel routine;
  final int workoutCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: kWhite,
        automaticallyImplyLeading: false, // Disable default leading behavior
        title: Row(
          children: [
            IconButton(
              color: kBlack,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              padding: EdgeInsets.zero, // Remove default padding
              constraints: BoxConstraints(), // Remove minimum size constraints
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                routine.name,
                style: kPageTitle.copyWith(color: kBlack),
                overflow: TextOverflow.ellipsis, // Handle long names gracefully
              ),
            ),
          ],
        ),
        actions: [
          Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                print('Edit routine');
              },
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Important: minimize the row size
                children: [
                  Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 18,
                      color: kTextGrey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    'assets/icons/Edit_icon.png',
                    width: 25,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kWhite,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RoutineCardChip(label: routine.goal),
                            Text(
                              '$workoutCount Workouts • ${routine.workouts.length} Days/Week',
                              style: const TextStyle(
                                color: kTextGrey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: kBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            print('Start routine');
                            print(workoutCount);
                            // Navigator.push(
                            //   context,
                            // MaterialPageRoute(
                            //   builder: (context) => StartroutineScreen(
                            //     routine: routine,
                            //   ),
                            // ),
                            // );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: Text(
                              'Start Routine',
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '75%',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AnimatedProgressBar(
                          currentStep: 4, maxSteps: 6, color: kBlue),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workout Schedule',
                      style: kTitleCard,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: routine.workouts.entries
                          .map(
                            (day) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: kContainerElevation,
                                color: kWhite,
                              ),
                              margin: EdgeInsets.only(bottom: 10, top: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: ExpansionTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    day.key,
                                    style: kTitleCard,
                                  ),
                                  children: [
                                    Column(
                                      children: day.value
                                          .map(
                                            (w) => Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    w.name,
                                                    style: kNormalText,
                                                  ),
                                                  Text(
                                                    '${w.duration} min  •  ${w.exercises.length} exercises',
                                                    style: const TextStyle(
                                                      color: kTextGrey,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(

                                        
                                        style: TextButton.styleFrom(
                                            backgroundColor: kWhite,
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(color: kBlue),
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        onPressed: () {
                                          
                                          allWorkoutMBS(context, ref.watch(allWorkoutsProvider));




                                          // for (var i = 0; i < routine.workouts.length; i++) {
                                          //           print(routine.workouts.values);
                                          //         }
                                          // Navigator.push(
                                          //   context,
                                          // MaterialPageRoute(
                                          //   builder: (context) => StartroutineScreen(
                                          //     routine: routine,
                                          //   ),
                                          // ),
                                          // );
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add, color: kBlue,),
                                            Text(
                                              'Add Workout',
                                              style: TextStyle(
                                                color: kBlue,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                          .toList(),
                    ),
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
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: kBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () {
            print('Start routine');
            print(workoutCount);

            // for (var i = 0; i < routine.workouts.length; i++) {
            //           print(routine.workouts.values);
            //         }
            // Navigator.push(
            //   context,
            // MaterialPageRoute(
            //   builder: (context) => StartroutineScreen(
            //     routine: routine,
            //   ),
            // ),
            // );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: MediaQuery.of(context).size.width * 0.3),
            child: Text(
              'Start Routine',
              style: TextStyle(
                color: kWhite,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class routineInfoItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const routineInfoItem({
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
