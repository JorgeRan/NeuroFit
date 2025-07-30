import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/workout_logging_providers.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';

class SelectableMuscleFilterChip extends ConsumerWidget {
  final String label;
  final int questionIndex;
  final bool isSelected;

  const SelectableMuscleFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.questionIndex,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMuscles = ref.watch(selectedItemsProvider);

    final isSelected = selectedMuscles!.contains(label);


    return FilterChip(
      disabledColor: kLightGrey,
      side: BorderSide(
        color: isSelected ? Colors.transparent : kFieldBorder,
        width: 1.5,
      ),
      elevation: 3,
      checkmarkColor: Colors.white,
      labelStyle: kParagraphText.copyWith(
        color: isSelected ? Colors.white : Colors.black,
      ),
      label: Text(label),
      backgroundColor: Colors.white,
      selectedColor: kBlue,
      selected: isSelected,
      onSelected: (selected) {
        final selectedNotifier = ref.read(selectedItemsProvider.notifier);
        final unansweredNotifier = ref.read(unansweredQuestionsProvider.notifier);

        // Toggle selection state
        if (selected) {
          selectedNotifier.state = {...selectedNotifier.state, label};
        } else {
          selectedNotifier.state =
              selectedNotifier.state.where((e) => e != label).toSet();
        }

        // Update unanswered tracking
        if (selectedNotifier.state.isNotEmpty) {
          unansweredNotifier.state = {...unansweredNotifier.state}..remove(questionIndex);
        } else {
          unansweredNotifier.state = {...unansweredNotifier.state}..add(questionIndex);
        }
      },
    );
  }
}
