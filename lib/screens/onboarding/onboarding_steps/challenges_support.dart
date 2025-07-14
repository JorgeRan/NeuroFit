import 'package:flutter/material.dart';
import 'package:neurofit_app/screens/onboarding_screen.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengesSupportStep extends ConsumerWidget {
  const ChallengesSupportStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedChallengeProvider);
    ref.watch(selectedReminderProvider);
    final support = ref.watch(selectedSupportProvider);

    return SingleChildScrollView(
      //controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              "What's your biggest health challenge right now?",
              style: kQuestionsText,
            ),
          ),
          if (ref.watch(unansweredQuestionsProvider).contains(0))
            Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          RadioButtons(
            filter: challengeFilter,
            provider: selectedChallengeProvider,
            questionIndex: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text(
              "How often do you want health tips/reminders?",
              style: kQuestionsText,
            ),
          ),
          if (ref.watch(unansweredQuestionsProvider).contains(1))
            Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          RadioButtons(
            filter: remindersFilter,
            provider: selectedReminderProvider,
            questionIndex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text(
              "How would you like to be supported?",
              style: kQuestionsText,
            ),
          ),
          const Text(
            "You can select more than one",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Column(
            children: supportTone.map((level) {
              final isSelected = support.contains(level['value']);
              return GestureDetector(
                onTap: () {
                  final notifier = ref.read(selectedSupportProvider.notifier);
                  final value = level['value'];

                  if (value == 'other') {
                    notifier.state = {'other'};
                  } else {
                    final updated = {...notifier.state};

                    updated.remove('other');

                    if (updated.contains(value)) {
                      updated.remove(value);
                    } else {
                      updated.add(value!);
                    }

                    notifier.state = updated;
                  }
                  final current = ref.read(unansweredQuestionsProvider);
                  ref.read(unansweredQuestionsProvider.notifier).state = {
                    ...current..remove(2),
                  };
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? kBlue
                          : ref.watch(unansweredQuestionsProvider).contains(2)
                              ? Colors.red
                              : kFieldBorder,
                      width: 2,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: isSelected ? kBlue : kFieldBorder,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                level['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                level['description'] ?? '',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
