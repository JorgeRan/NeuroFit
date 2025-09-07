import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

final logWorkoutProvider = StateProvider<String>((ref) => '');

final selectedValueProvider = StateProvider<String>(
  (ref) => '',
);

final workoutType = [
  'Strenght',
  'Cardio',
  'Mobility',
];

class WorkoutInformationView extends ConsumerWidget {
  const WorkoutInformationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(selectedValueProvider);

    final isUnanswered = false;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionTextWidget(
            question: 'Workout Name',
          ),
          CustomTextField(
            workoutNameProvider,
            'e.g., Leg Day Burn',
            false,
            '',
            false,
            'Workout Name',
            0,
          ),
          QuestionTextWidget(question: 'Description (optional)'),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Any additional notes...',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kFieldBorder),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kFieldBorder),
              ),
            ),
            onChanged: (value) {
              ref.read(workoutDescriptionProvider.notifier).state = value;
            },
          ),
          QuestionTextWidget(question: 'Workout Type'),
          Wrap(
            spacing: 2,
            runSpacing: 2,
            children: workoutType.map((Type) {
              return SelectableMuscleFilterChip(
                label: Type,
                isSelected: false,
                questionIndex: 3,
              );
            }).toList(),
          ),
          QuestionTextWidget(question: "Estimated Duration (minutes)"),
          Container(
            decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: double.infinity,
            height: 48,
            child: TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref.read(workoutDurationProvider.notifier).state = value;

                // ref.read(unansweredAccountQuestions.notifier).update((state) {
                //   final newState = {...state};
                //   newState.remove(questionIndex);
                //   return newState;
                // });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.schedule_outlined),
                suffixText: 'minutes',
                suffixStyle: kParagraphText,
                fillColor: kWhite,
                hintText: 'e.g., 30',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isUnanswered ? Colors.red : kFieldBorder,
                      width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isUnanswered ? Colors.red : kFieldBorder,
                      width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }
}
