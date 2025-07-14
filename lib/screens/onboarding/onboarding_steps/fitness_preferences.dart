import 'package:flutter/material.dart';
import 'package:neurofit_app/screens/onboarding_screen.dart';
import 'package:neurofit_app/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/widgets.dart';

class FitnessPreferencesStep extends ConsumerWidget {
  const FitnessPreferencesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return SingleChildScrollView(
        child: SingleChildScrollView(
      //controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text("What's is your fitness level?", style: kQuestionsText),
          ),
          if (ref.watch(unansweredQuestionsProvider).contains(0))
            Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          RadioButtons(
            filter: fitnessFilter,
            provider: selectedFitnessLevelProvider,
            questionIndex: 0,
          ),
          MultipleChoiceQuestion(
            question: "What types of workouts are you interested in?",
            filter: workoutFilter,
            haveIcon: true,
            selectedItemsProvider: selectedWorkoutTypesProvider,
            questionIndex: 1,
          ),

          
          if (ref.watch(unansweredQuestionsProvider).contains(1))
            OptionsErrorMessage(),
          MultipleChoiceQuestion(
            question: "Do you have access to equipment?",
            filter: equipmentFilter,
            haveIcon: true,
            selectedItemsProvider: selectedEquipmentProvider,
            questionIndex: 2,
          ),

          
          if (ref.watch(unansweredQuestionsProvider).contains(2))
            OptionsErrorMessage(),
        ],
      ),
    ));
  }
}
