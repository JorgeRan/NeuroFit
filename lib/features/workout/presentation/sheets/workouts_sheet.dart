import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/shared/presentation/screens/navigation_screen.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/presentation/dialogs/exercise_parameter_dialog.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';

Future<dynamic> allWorkoutMBS(
  BuildContext context,
  List<WorkoutModel> dayWorkouts,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Exercise Details', style: kTitleCard),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dayWorkouts.map((workout) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: kFieldBorder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(workout.name, style: kTitleCard),
                                
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: [
                                      ...workout.targetMuscle.take(3).map(
                                          (muscle) =>
                                              WorkoutCardChip(label: muscle)),
                                      if (workout.targetMuscle.length > 3)
                                        Text(
                                          '+${workout.targetMuscle.length - 3} more',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                
                                Text(
                                  '${workout.duration} mins  •  ${workout.exercises.length} exercises',
                                  style: const TextStyle(
                                    color: kTextGrey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: kBlue,
                                ),
                                child:
                                    const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
