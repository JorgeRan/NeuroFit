import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/presentation/dialogs/exercise_parameter_dialog.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';

Future<dynamic> exerciseListMBS(context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // lets it take full height if needed
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // adjust height based on content
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Exercise Details',
                        style: kTitleCard,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: chestExercises.map((exercise) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: kFieldBorder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start, // align text left
                                children: [
                                  Text(
                                    exercise.name,
                                    style: kTitleCard,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    spacing: 6,
                                    children: [
                                      WorkoutCardChip(
                                        label: exercise.muscleGroup,
                                      ),
                                      WorkoutCardChip(
                                          label:
                                              'Equipment: ${exercise.equipment}'),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: kBlue,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      exerciseParameterDialog(
                                          context, exercise, true);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: kWhite,
                                    ),
                                  ))
                            ],
                          ),
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
