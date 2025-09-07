import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

class ReviewSaveView extends ConsumerWidget {
  const ReviewSaveView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(

            color: kWhite,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),
                  child: Text(
                    ref.watch(workoutNameProvider),
                    style: kScreenTitle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            color: kBlack,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${ref.watch(workoutTypeProvider)} Workout',
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            color: kBlack,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${ref.watch(workoutDurationProvider)} min',
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            
            color: kWhite,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),
                  child: Text(
                    'Target Muscles',
                    style: kTitleCard,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      ...ref.watch(selectedMuscleGroupsProvider).map(
                            (muscle) => SelectedMuscleChip(label: muscle),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            color: kWhite,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Exercises',
                        style: kTitleCard,
                      ),
                      Text(
                        '${ref.watch(selectedExercisesProvider).length} total',
                        style: TextStyle(color: kTextGrey, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: ref.watch(selectedExercisesProvider).map((exercise) {
                    final lastItemIndex =
                        ref.watch(selectedExercisesProvider).length - 1;
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: kFieldBorder),
                        borderRadius: BorderRadius.only(
                          bottomRight:
                              ref.watch(selectedExercisesProvider)[lastItemIndex] ==
                                      exercise
                                  ? Radius.circular(10)
                                  : Radius.circular(0),
                          bottomLeft:
                              ref.watch(selectedExercisesProvider)[lastItemIndex] ==
                                      exercise
                                  ? Radius.circular(10)
                                  : Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${ref.watch(selectedExercisesProvider).indexOf(exercise) + 1}. ${exercise.name}', style: kTitleCard,),
                          Text(exercise.muscleGroup, style: TextStyle(color: kTextGrey, fontSize: 15),),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
