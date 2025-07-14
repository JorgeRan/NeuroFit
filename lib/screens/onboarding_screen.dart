import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/screens/navigation_screen.dart';
import 'package:neurofit_app/widgets.dart';
import 'onboarding/onboarding_steps/basic_info.dart';
import 'onboarding/onboarding_steps/challenges_support.dart';
import 'onboarding/onboarding_steps/dietary_preferences.dart';
import 'onboarding/onboarding_steps/fitness_preferences.dart';
import 'onboarding/onboarding_steps/health_goals.dart';

import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/screens/navigation/home_page.dart';

// Step counter
final counterProvider = StateProvider<int>((ref) => 0);
final previousCounterProvider = StateProvider<int>((ref) => 0);

// Age
final selectedAgeProvider = StateProvider<String?>((ref) => '');

// Gender
enum Gender { male, female }

final selectedGenderProvider = StateProvider<Gender?>((ref) => null);

// Height
final selectedHeightProvider = StateProvider<String?>((ref) => '');
final selectedHeightUnitProvider = StateProvider<String?>((ref) => null);
final selectedInProvider = StateProvider<String?>((ref) => '');
final selectedFtProvider = StateProvider<String?>((ref) => '');

// Weight
final selectedWeightProvider = StateProvider<String?>((ref) => '');
final selectedWeightUnitProvider = StateProvider<String?>((ref) => null);

// Activity
final selectedActivityLevelProvider = StateProvider<String?>((ref) => null);
final selectedHealthGoalsProvider = StateProvider<Set<String>>((ref) => {});

// Fitness
final selectedFitnessLevelProvider = StateProvider<dynamic>((ref) => null);
final selectedWorkoutTypesProvider = StateProvider<Set<String>>((ref) => {});
final selectedEquipmentProvider = StateProvider<Set<String>>((ref) => {});

// Diet
final selectedDietsProvider = StateProvider<Set<String>>((ref) => {});
final selectedCalorieProvider = StateProvider<dynamic>((ref) => null);
final selectedCalorieChoiceProvider = StateProvider<String?>((ref) => null);
final calorieGoalChoiceProvider = StateProvider<String?>((ref) => '');

// Challenge / Reminder / Support
final selectedChallengeProvider = StateProvider<dynamic>((ref) => null);
final selectedReminderProvider = StateProvider<dynamic>((ref) => null);
final selectedSupportProvider = StateProvider<Set<String>>((ref) => {});

final unansweredQuestionsProvider = StateProvider<Set<int>>((ref) => {});

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final previousCounter = ref.watch(previousCounterProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                _buildTopBar(context, ref),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimationQuestions(
                        previousCounter: previousCounter,
                        counter: counter,
                        child: Text(
                          onboardingTitles[counter],
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedProgressBar(
                        currentStep: counter,
                        maxSteps: 5,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: AnimationQuestions(
                          previousCounter: previousCounter,
                          counter: counter,
                          child: StepContent(
                            counter: counter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey, thickness: 2),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _handleNext(context, ref);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(counter < 4 ? 'Next' : 'Finish',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, WidgetRef ref) {
    final counter = ref.read(counterProvider.notifier);
    ref.read(previousCounterProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (counter.state > 0) {
                counter.state--;
              } else {
                Navigator.pop(context);
              }
              if (counter.state == 5) {
                ref.read(counterProvider.notifier).state = 0;
              }
            },
            child: Icon(Icons.arrow_back_ios_new,
                color: ref.watch(counterProvider) == 0 ? kLightGrey : kBlue,
                size: 24),
          ),
          Hero(
            tag: 'welcomeTitle',
            child: Text('NeuroFit', style: kAppName),
          ),
        ],
      ),
    );
  }

  void _handleNext(BuildContext context, WidgetRef ref) {
    final counter = ref.read(counterProvider.notifier);
    final previousCounter = ref.read(previousCounterProvider.notifier);
    previousCounter.state = counter.state;

    if (ref.watch(selectedHeightUnitProvider) == 'ft / in') {
      ref.read(selectedHeightProvider.notifier).state =
          "${ref.watch(selectedFtProvider)} ft ${ref.watch(selectedInProvider)} in";
    }

    

    final currentStep = counter.state;

    final unanswered = <int>{};

    for (int i = 0; i < stepAllProviders[currentStep].length; i++) {
      final val = ref.watch(stepAllProviders[currentStep][i]);
      if (val == null ||
          (val is String && val.trim().isEmpty) ||
          (val is Set && val.isEmpty) ||
          (val is List && val.isEmpty) ||
          (val is Map && val.isEmpty)) {
        unanswered.add(i);
      }
    }

    print(unanswered);
    ref.read(unansweredQuestionsProvider.notifier).state = unanswered;

    if (unanswered.isEmpty) {
      counter.state++;
    }

    if (counter.state == 5) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavigationScreen()));
    }

    //counter.state++;

    // print(
    //     'Age: ${ref.watch(selectedAgeProvider)}, Sex: ${ref.watch(selectedGenderProvider)}, Height: ${ref.watch(selectedHeightProvider)}, Weight: ${ref.watch(selectedWeightProvider)}');

    // if (counter.state == 2) {
    //   print(
    //       'Activity Level: ${ref.watch(selectedActivityLevelProvider)}, Health Goals: ${ref.watch(selectedHealthGoalsProvider)}');
    // }
    // if (counter.state == 3) {
    //   print(
    //       'Fitness Level: ${ref.watch(selectedFitnessLevelProvider)}, Workout: ${ref.watch(selectedWorkoutTypesProvider)}, Equipment: ${ref.watch(selectedEquipmentProvider)}');
    // }
    // if (counter.state == 4) {
    //   print(
    //       'Diet: ${ref.watch(selectedDietsProvider)}, Calorie Choice: ${ref.watch(selectedCalorieChoiceProvider)}, Calorie Goal: ${ref.watch(calorieGoalChoiceProvider)}');
    // }
    // if (counter.state == 5) {
    //   print(
    //       'Health Challenge: ${ref.watch(selectedChallengeProvider)}, Reminder: ${ref.watch(selectedReminderProvider)}, Tone: ${ref.watch(selectedSupportProvider)}');
    // }
  }
}

class StepContent extends ConsumerWidget {
  final int counter;

  const StepContent({super.key, required this.counter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (counter) {
      case 0:
        return BasicInfo();
      case 1:
        return ActivityGoalsStep();
      case 2:
        return FitnessPreferencesStep();
      case 3:
        return DietaryPreferencesStep();
      case 4:
        return ChallengesSupportStep();
      case 5:
        return Center(child: Text('Unknown step'));
      default:
        return Center(
          child: Text('Unknown widget'),
        );
    }
  }
}
