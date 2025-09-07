import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-workout-views/add_exercise_view.dart';

final tempSetsProvider = StateProvider<Map<String, int>>((ref) => {});

Future<dynamic> exerciseParameterDialog(
  BuildContext context,
  WorkoutExercise selectedExercise,
  bool isNewExercise,
) {
  return showDialog(
    context: context,
    builder: (_) => Consumer(
      builder: (context, ref, _) {
        final exerciseList = ref.watch(selectedExercisesProvider);
        // final exercise =
        //     exerciseList.where((e) => e.name == selectedExercise).toList();

        // if (exercise.isEmpty) {
        //   print('Exercise not found: $selectedExercise');

        // }

        final sets = selectedExercise.sets;
        final tempSets = ref.watch(tempSetsProvider);

        int numberOfSets = sets.length;

        return StatefulBuilder(
          builder: (context, setState) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            insetPadding: EdgeInsets.zero,
            backgroundColor: kWhite,
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width * 0.95,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(selectedExercise.name, style: kTitleCard),
                      ),
                      _buildTags(selectedExercise),
                      const SizedBox(height: 15),
                      _buildSwitch(selectedExercise, ref),
                      _buildSetsStepper(context, sets, ref, setState),
                      if (!ref.watch(varyBetweenSetsProvider) &&
                          sets.isNotEmpty)
                        ..._buildUniformControls(context, sets, ref, setState),
                      if (ref.watch(varyBetweenSetsProvider))
                        ..._buildVaryingControls(context, sets, setState),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                      _buildSaveButton(
                        context,
                        sets,
                        isNewExercise,
                        selectedExercise,
                        tempSets,
                        ref,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildHeader(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Exercise Parameters', style: kTitleCard),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );

Widget _buildTags(WorkoutExercise selectedExercise) => Wrap(
      spacing: 8,
      children: [
        WorkoutCardChip(
          label: selectedExercise.muscleGroup,
        ),
        WorkoutCardChip(label: 'Equipment: ${selectedExercise.equipment}'),
      ],
    );

Widget _buildSwitch(WorkoutExercise selectedExercise, WidgetRef ref) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Vary between sets?", style: kQuestionsText),
        Switch(
            activeColor: kBlue,
            inactiveTrackColor: kGreyChipColor,
            value: ref.watch(varyBetweenSetsProvider),
            onChanged: (val) {
              selectedExercise.varySets = val;
              ref.read(varyBetweenSetsProvider.notifier).state = val;
            })
      ],
    );

Widget _buildSetsStepper(
  BuildContext context,
  List<SetDetail> sets,
  WidgetRef ref,
  void Function(void Function()) setState,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFB),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Sets", style: kTitleCard),
        CartStepperInt(
          count: sets.length, // live value, not snapshot
          size: MediaQuery.sizeOf(context).width * 0.08,
          style: CartStepperTheme.of(context).copyWith(
            activeForegroundColor: kWhite,
            activeBackgroundColor: kBlue,
          ),
          didChangeCount: (count) {
            setState(() {
              if (count == 0) {
                sets.clear();
              } else if (sets.length < count) {
                sets.addAll(List.generate(
                  count - sets.length,
                  (_) => SetDetail(reps: 10, weight: 50.0),
                ));
              } else {
                sets.removeRange(count, sets.length);
              }
            });

            ref.read(tempSetsProvider.notifier).state = {
              ...ref.read(tempSetsProvider),
              ref
                  .read(selectedExercisesProvider)
                  .firstWhere((e) => e.sets == sets)
                  .name: count,
            };
          },
        ),
      ],
    ),
  );
}

List<Widget> _buildUniformControls(BuildContext context, List<SetDetail> sets,
    WidgetRef ref, void Function(void Function()) setState) {
  return [
    _uniformStepper(
      label: "Reps (all sets)",
      value: sets[0].reps,
      onChanged: (val) => setState(
        () => sets.forEach((set) => set.reps = val),
      ),
      context: context,
    ),
    _uniformStepper(
      label: "Weight (lbs, all sets)",
      value: sets[0].weight!.toInt(),
      step: 5,
      onChanged: (val) => setState(
        () => sets.forEach((set) => set.weight = val.toDouble()),
      ),
      context: context,
    ),
  ];
}

Widget _uniformStepper({
  required String label,
  required int value,
  int step = 1,
  required void Function(int) onChanged,
  required BuildContext context,
}) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: kTitleCard),
          CartStepperInt(
            count: value,
            stepper: step,
            size: MediaQuery.sizeOf(context).width * 0.08,
            style: CartStepperTheme.of(context).copyWith(
              activeForegroundColor: kWhite,
              activeBackgroundColor: kBlue,
            ),
            didChangeCount: onChanged,
          ),
        ],
      ),
    );

List<Widget> _buildVaryingControls(BuildContext context, List<SetDetail> sets,
    void Function(void Function()) setState) {
  return List.generate(sets.length, (i) {
    final set = sets[i];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Set ${i + 1}", style: kQuestionsText),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFB),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: set.reps == 0 ? MediaQuery.sizeOf(context).width * 0.135 : 15,
            right:
                set.weight == 0 ? MediaQuery.sizeOf(context).width * 0.07 : 15,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _varyStepper(context, "Reps", set.reps,
                  (val) => setState(() => set.reps = val)),
              _varyStepper(context, "Weight (lbs)", set.weight!.toInt(),
                  (val) => setState(() => set.weight = val.toDouble()),
                  step: 5),
            ],
          ),
        ),
      ],
    );
  });
}

Widget _varyStepper(BuildContext context, String label, int value,
        void Function(int) onChanged,
        {int step = 1}) =>
    Column(
      children: [
        Text(label, style: kParagraphText),
        const SizedBox(height: 10),
        CartStepperInt(
          count: value,
          stepper: step,
          size: MediaQuery.sizeOf(context).width * 0.08,
          style: CartStepperTheme.of(context).copyWith(
            activeForegroundColor: kWhite,
            activeBackgroundColor: kBlue,
          ),
          didChangeCount: onChanged,
        ),
      ],
    );

Widget _buildSaveButton(
    BuildContext context,
    List<SetDetail> sets,
    bool isNewExercise,
    WorkoutExercise selectedExercise,
    Map<String, int> tempSets,
    WidgetRef ref) {
  return Align(
    alignment: Alignment.bottomRight,
    child: ElevatedButton(
      onPressed: () {
        if (sets.isEmpty) return;

        Navigator.pop(context);

        final count = tempSets[selectedExercise.name] ?? sets.length;
        final chosenWeight = sets[0].weight; 

        ref.read(selectedExercisesProvider.notifier).update((state) {
          final isNew = !state.any((e) => e.name == selectedExercise.name);

          if (isNew) {
            return [
              ...state,
              WorkoutExercise(
                name: selectedExercise.name,
                muscleGroup: selectedExercise.muscleGroup,
                varySets: selectedExercise.varySets,
                sets: List.generate(
                  count > 0 ? count : 1,
                  (_) => SetDetail(reps: 10, weight: chosenWeight!.toDouble()),
                ),
                equipment: selectedExercise.equipment,
              ),
            ];
          } else {
            // Update existing exercise sets while keeping user weights
            return state.map((exercise) {
              if (exercise.name != selectedExercise.name) return exercise;

              final oldSets = exercise.sets;

              final newSets = List.generate(count > 0 ? count : 1, (index) {
                if (index < oldSets.length) {
                  return oldSets[index]; 
                } else {
                  return SetDetail(
                      reps: 10,
                      weight: oldSets.isNotEmpty
                          ? oldSets.last.weight
                          : chosenWeight!.toDouble());
                }
              });

              return WorkoutExercise(
                name: exercise.name,
                muscleGroup: exercise.muscleGroup,
                varySets: exercise.varySets,
                sets: newSets,
                equipment: exercise.equipment,
              );
            }).toList();
          }
        });

        ref.read(tempSetsProvider.notifier).state = {};
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: sets.isEmpty ? kBlue.withOpacity(0.1) : kBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Save',
          style: TextStyle(
            color: kWhite,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
