import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/presentation/sheets/exercise_list_MBS.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/presentation/dialogs/exercise_parameter_dialog.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'dart:convert';

final setsProvider = StateProvider<int>((ref) => 3);
final repsProvider = StateProvider<List<int>>((ref) => [10]);

void updateMyExercises(int oldIndex, int newIndex, WidgetRef ref) {
  ref.read(selectedExercisesProvider.notifier).update((state) {
    final newState = [...state];

    final exercise = newState.removeAt(oldIndex);

    if (newIndex > oldIndex) newIndex--;

    newState.insert(newIndex, exercise);

    return newState;
  });
}

class AddExerciseView extends ConsumerWidget {
  const AddExerciseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMuscles = ref.watch(selectedMuscleGroupsProvider);
    final selectedExercises = ref.watch(selectedExercisesProvider);
    final sets = ref.watch(setsProvider);
    final reps = ref.watch(repsProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuestionTextWidget(
              question: 'Select a muscle group to add exercises'),
          SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedMuscles.map((muscle) {
              return GestureDetector(
                onTap: () => exerciseListMBS(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.05), // soft shadow
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.4162,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          muscle,
                          style: kQuestionsText.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const Icon(Icons.add, color: kBlue),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const QuestionTextWidget(question: 'Selected Exercises:'),
          const SizedBox(height: 10),
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) =>
                updateMyExercises(oldIndex, newIndex, ref),
            proxyDecorator: (child, index, animation) {
              return Material(
                color: Colors.transparent,
                child: child,
              );
            },
            children: selectedExercises.map(
              (exercise) {
                return Container(
                  key: ValueKey(exercise),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border.all(color: kFieldBorder),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            // ignore: deprecated_member_use
                            Colors.black.withOpacity(0.05), // soft shadow
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ReorderableDragStartListener(
                            index: selectedExercises.indexOf(exercise),
                            child: const Icon(Icons.drag_indicator,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise.name,
                                style: kQuestionsText.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(
                                '${exercise.muscleGroup} • ${exercise.sets.length} sets',
                                style:
                                    TextStyle(color: kTextGrey, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Actions
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                print(exercise.name);
                                exerciseParameterDialog(
                                  context,
                                  exercise,
                                  false,
                                );
                                ref
                                    .read(varyBetweenSetsProvider.notifier)
                                    .state = exercise.varySets;
                              },
                              child:
                                  Icon(Icons.edit_rounded, color: kTextGrey)),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              ref
                                  .read(selectedExercisesProvider.notifier)
                                  .update((state) {
                                final newState = [...state];
                                newState.remove(exercise);
                                return newState;
                              });
                            },
                            child: const Icon(Icons.remove, color: kRed),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
