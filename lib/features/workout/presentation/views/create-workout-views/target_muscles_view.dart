import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/presentation/screens/my_workouts_screen.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';



class TargetMusclesView extends ConsumerWidget {
  const TargetMusclesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFront = ref.watch(isFrontProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionTextWidget(
              question: 'Tap on muscle groups to select target areas'),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              ...ref.watch(selectedMuscleGroupsProvider).map(
                    (muscle) => SelectedMuscleChip(label: muscle),
                  ),
            ],
          ),
          TextButton(
            onPressed: () =>
                ref.read(isFrontProvider.notifier).state = !isFront,
            child: Text(isFront ? 'Show Back' : 'Show Front'),
          ),
          InteractiveBody(true, isFront: isFront),
        ],
      ),
    );
  }
}
