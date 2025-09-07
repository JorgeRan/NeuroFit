import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/presentation/dialogs/exercise_parameter_dialog.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';

Future<dynamic> allWorkoutExercisesMBS(
    context, List<WorkoutExercise> exercises) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Exercises',
                          style: kTitleCard,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Column(
                    children: exercises.map((exercise) {
                      return Container(
                        decoration: BoxDecoration(
                          color:  Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            
                            bottom: BorderSide(color: kFieldBorder),
                            
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: kBlue),
                                   
                                child: Center(
                                  child: Text(
                                    '${exercises.indexOf(exercise) + 1}',
                                    style: TextStyle(
                                        color: kWhite,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
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
                                  Text('${exercise.sets.length} sets')
                                ],
                              ),
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
