import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/features/workout/data/providers/create_routine_providers.dart';


final selectedWorkoutProvider = StateProvider<String?>((ref) => null,);

class WorkoutDays extends ConsumerWidget {
  const WorkoutDays({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutDaysPlan = ref.watch(workoutDaysPlanProvider);
    final items = ref.watch(allWorkoutsProvider);
    final _selectedWorkout = ref.watch(selectedWorkoutProvider);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You can add multiple workouts per day.',
            style: kNormalText,
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: workoutDaysPlan.entries.map(
              (entry) {
                final dayKey = entry.key;

                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kFieldBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: const Color.fromARGB(255, 232, 233, 236)),
                        child: Text(
                          entry.key,
                          style: kNormalText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: entry.value.isEmpty
                            ? Text('No workouts added yet')
                            : Column(
                                children: entry.value
                                    .map(
                                      (workout) => Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 232, 233, 236),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              workout.name,
                                              style: kNormalText,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(
                                                        workoutDaysPlanProvider
                                                            .notifier)
                                                    .update((plan) {
                                                  final updatedList =
                                                      List<WorkoutModel>.from(
                                                          plan[entry.key] ??
                                                              []);

                                                  // remove the specific workout
                                                  updatedList.removeWhere((w) =>
                                                      w.id == workout.id);

                                                  return {
                                                    ...plan,
                                                    entry.key: updatedList,
                                                  };
                                                });
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: kRed,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor: kWhite,
                     value: _selectedWorkout,
                          hint: Text('Add Workout'),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kFieldBorder),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kFieldBorder),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? newId) {
                            if (newId != null) {
                              final workout =
                                  items.firstWhere((w) => w.id == newId);

                              ref
                                  .read(workoutDaysPlanProvider.notifier)
                                  .update((plan) {
                                final updatedList = [
                                  // ignore: unnecessary_cast
                                  ...((plan[dayKey] ?? [])
                                      as List<WorkoutModel>),
                                  workout,
                                ];
                                return {
                                  ...plan,
                                  dayKey: updatedList,
                                };
                              });

                              ref.read(selectedWorkoutProvider.notifier).state = null;
                            }
                          },
                          items: items.map((WorkoutModel value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
          if (workoutDaysPlan.length <= 2)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.19,
            ),
        ],
      ),
    );
  }
}
