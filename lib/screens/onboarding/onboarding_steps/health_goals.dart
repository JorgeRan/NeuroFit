import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/screens/onboarding_screen.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/widgets.dart';

class ActivityGoalsStep extends ConsumerWidget {
  const ActivityGoalsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedActivityLevel = ref.watch(selectedActivityLevelProvider);

    return SingleChildScrollView(
      //controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              "What's your current activity level?",
              style: kQuestionsText,
            ),
          ),
          const SizedBox(height: 10),
          SingleSelectQuestion(
            options: activityLevels,
            input: selectedActivityLevel,
            questionIndex: 0,
            onTap: (val) =>
                ref.read(selectedActivityLevelProvider.notifier).state = val,
          ),
          if (ref.watch(unansweredQuestionsProvider).contains(0))
            OptionsErrorMessage(),
          MultipleChoiceQuestion(
            question: "What are your health goals?",
            filter: goalFilter,
            haveIcon: true,
            selectedItemsProvider: selectedHealthGoalsProvider,
            questionIndex: 1,
          ),

          // MultipleChoiceQuestion(
          //   question: "What are your health goals?",
          //   filter: goalFilter,
          //   haveIcon: true,
          //   selectedItem: selectedHealthGoals,
          //   isUnanswered: ref.watch(unansweredQuestionsProvider).contains(1),
          //   onSelectionChanged: (label, selected) {
          //     final notifier = ref.read(selectedHealthGoalsProvider.notifier);
          //     if (selected) {
          //       notifier.state = {...notifier.state, label};
          //     } else {
          //       notifier.state =
          //           notifier.state.where((e) => e != label).toSet();
          //     }
          //   },
          // ),
          if (ref.watch(unansweredQuestionsProvider).contains(0))
            OptionsErrorMessage(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
