import 'package:flutter/material.dart';
import 'package:neurofit_app/screens/onboarding/onboarding_screen.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DietaryPreferencesStep extends ConsumerWidget {
  const DietaryPreferencesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      //controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MultipleChoiceQuestion(
            question: "Do you have any dietary preferences?",
            filter: dietFilter,
            haveIcon: false,
            selectedItemsProvider: selectedDietsProvider,
            questionIndex: 0,
          ),
          if (ref.watch(unansweredQuestionsProvider).contains(0))
            OptionsErrorMessage(),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Do you have a daily calorie goal?",
                style: kQuestionsText),
          ),
          if (ref.watch(unansweredQuestionsProvider).contains(0))
            Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          Column(
            children: calorieFilter.map((level) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedCalorieProvider.notifier).state = level;
                      ref.read(selectedCalorieChoiceProvider.notifier).state =
                          level.label;
                    },
                    child: Row(
                      children: [
                        Radio<dynamic>(
                          value: level,
                          groupValue: ref.watch(selectedCalorieProvider),
                          onChanged: (value) {
                            ref.read(selectedCalorieProvider.notifier).state =
                                value;
                            ref
                                .read(selectedCalorieChoiceProvider.notifier)
                                .state = value.label;
                          },
                          activeColor: kBlue,
                        ),
                        Text(
                          level.label,
                          style: kParagraphText,
                        ),
                      ],
                    ),
                  ),
                  if (level.label == "Yes, I have one" &&
                      ref.watch(selectedCalorieChoiceProvider) ==
                          "Yes, I have one")
                    CustomTextField(
                        calorieGoalChoiceProvider,
                        'Enter your goal (e.g., 2200 cal)',
                        false,
                        'cal',
                        true,
                        'Calorie Goal',
                        0),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
