import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_routine_providers.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

final logWorkoutProvider = StateProvider<String>((ref) => '');

final selectedValueProvider = StateProvider<String>(
  (ref) => '',
);



class RoutineNameView extends ConsumerWidget {
  const RoutineNameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(selectedValueProvider);

    final isUnanswered = false;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Text(
            'Give your workout routine a name to identify it.',
            style: kTitleCard.copyWith(fontWeight: FontWeight.normal, fontSize: 18),
          ),
          SizedBox(height: 15,),
          CustomTextField(
            routineNameProvider,
            'e.g., Push Pull Legs, Full Body Split',
            false,
            '',
            false,
            'Workout Name',
            0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.54,
          ),
        ],
      ),
    );
  }
}
