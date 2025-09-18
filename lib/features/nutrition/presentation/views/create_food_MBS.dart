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

final testProvider = StateProvider<String>((ref) => '',);

Future<dynamic> createFoodMBS(context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                      Text(
                        'Create My Food',
                        style: kTitleCard,
                      ),
                      const Icon(
                        Icons.close,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Text(
                    'Details',
                    style: kTitleCard,
                  ),
                  QuestionTextWidget(question: 'Food Name'),
                  CustomTextField(testProvider, 'Avocado Toast', false, '', false, '', 0),
                  QuestionTextWidget(question: 'Serving Quantity'),
                  CustomTextField(testProvider, '1', false, '', false, '', 1),
                  QuestionTextWidget(question: 'Ingredients'),
                  Column(
                    children: [],
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
