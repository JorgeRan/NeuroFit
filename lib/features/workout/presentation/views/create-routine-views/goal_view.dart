import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_routine_providers.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';


class GoalView extends ConsumerWidget {
  const GoalView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRoutineGoal = ref.watch(routineGoalProvider);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the primary focus to this routine.',
            style: kTitleCard.copyWith(
                fontWeight: FontWeight.normal, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          SingleSelectQuestion(
            options: fitnessGoals,
            input: selectedRoutineGoal,
            questionIndex: 0,
            onTap: (val) =>
                ref.read(routineGoalProvider.notifier).state = val,
          ),
        ],
      ),
    );
  }
}
