import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/workout_logging_providers.dart';

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

    final isSelected = selectedMuscles.contains(label);


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

class WorkoutSuggestion extends StatelessWidget {
  const WorkoutSuggestion({
    super.key,
    required this.label,
    required this.text,
    required this.emogi,
  });

  final String label;
  final String text;
  final String emogi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: kFieldBorder),
          borderRadius: BorderRadius.circular(12),
          color: kWorkoutPageColor,
          
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emogi,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                            color: kBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: kTextGrey,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'View Suggestions',
              style: TextStyle(
                  color: kBlue, fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class WorkoutCardChip extends StatelessWidget {
  const WorkoutCardChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: kGreyChipColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(label, style: TextStyle(color: kBlack)),
    );
  }
}


class SelectedMuscleChip extends StatelessWidget {
  const SelectedMuscleChip({
    super.key,
    required this.label,
  });

  final String label;

  


  Color _darkenColor(Color color, [double amount = .45]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final chipColor = muscleGroupColors[label] ?? Colors.grey;
    final textColor = _darkenColor(chipColor);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}



class WorkoutCardButtons extends StatelessWidget {
  const WorkoutCardButtons({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: kFieldBorder),
            right: BorderSide(color: kFieldBorder),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: label == 'Start Now' ? kBlue : kTextGrey,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: TextStyle(
                  color: label == 'Start Now' ? kBlue : kTextGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class RoutineCardChip extends StatelessWidget {
  const RoutineCardChip({
    super.key,
    required this.label,
  });

  final String label;

  


  Color _darkenColor(Color color, [double amount = .45]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final chipColor = trainingGoalColors[label] ?? Colors.grey;
    final textColor = _darkenColor(chipColor);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
