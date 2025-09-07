import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/features/workout/data/providers/create_routine_providers.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/logic/models/routine_model.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';
import 'package:neurofit_app/features/workout/presentation/screens/exercise_screen.dart';
import 'package:neurofit_app/features/workout/presentation/screens/my_workouts_screen.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-routine-views/days_view.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-routine-views/goal_view.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-routine-views/routine_name_view.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-routine-views/routine_target.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-routine-views/workout_days.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-workout-views/add_exercise_view.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-workout-views/review_save_view.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-workout-views/target_muscles_view.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-workout-views/workout_information_view.dart';
import 'package:neurofit_app/shared/presentation/screens/navigation_screen.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'dart:convert';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/home/presentation/screens/home_screens.dart';

final createRoutineCounterProvider = StateProvider<int>((ref) => 0);
final createRoutinePreviousCounterProvider = StateProvider<int>((ref) => 0);

final unansweredQuestionsProvider = StateProvider<Set<int>>((ref) => {});

class CreateRoutineScreen extends ConsumerWidget {
  const CreateRoutineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(createRoutineCounterProvider);
    final previousCounter = ref.watch(createRoutinePreviousCounterProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                _buildTopBar(context, ref),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimationQuestions(
                        previousCounter: previousCounter,
                        counter: counter,
                        child: Text(createRoutineTitles[counter],
                            style: kTitleCard),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedProgressBar(
                        currentStep: counter,
                        maxSteps: 3,
                        color: kBlue,
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
                    child: Text(counter < 4 ? 'Next' : 'Create Routine',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
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
    final counter = ref.read(createRoutineCounterProvider.notifier);
    ref.read(createRoutinePreviousCounterProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (counter.state > 0) {
                counter.state--;
                if (counter.state == 2) {
                  ref.read(workoutDaysPlanProvider.notifier).state = {};
                  print(ref.watch(workoutDaysPlanProvider));
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.arrow_back_ios_new,
                color: ref.watch(createRoutineCounterProvider) == 0
                    ? kLightGrey
                    : kBlack,
                size: 24),
          ),
          Text('Create Routine', style: kPageTitle.copyWith(color: kBlack)),
        ],
      ),
    );
  }

  void _handleNext(BuildContext context, WidgetRef ref) {
    final counter = ref.read(createRoutineCounterProvider.notifier);
    final previousCounter =
        ref.read(createRoutinePreviousCounterProvider.notifier);
    previousCounter.state = counter.state;

    

    if (counter.state == 2) {
      for (int i = 1; i < ref.watch(selectedDayProvider) + 1; i++) {
        ref.read(workoutDaysPlanProvider.notifier).update((plan) {
          return {
            ...plan,
            'Day $i': [], 
          };
        });
      }
      print(ref.watch(workoutDaysPlanProvider));
    }

    if (counter.state == 4) {
      Navigator.pop(context);
      ref.read(createRoutineCounterProvider.notifier).state = 0;
      final currentList = ref.read(allRoutinesProvider);
      ref.read(allRoutinesProvider.notifier).state = [
        ...currentList,
        RoutineModel(
          name: ref.watch(routineNameProvider),
          goal: ref.watch(routineGoalProvider),
          workouts: ref.watch(workoutDaysPlanProvider),
        )
      ];

      final encoder = JsonEncoder.withIndent('  ');

      for (var i = 0; i < ref.watch(allRoutinesProvider).length; i++) {
        final prettyJson =
            encoder.convert(ref.watch(allRoutinesProvider)[i].toJson());

        print(prettyJson);
      }
    }

    // final currentStep = counter.state;

    // final unanswered = <int>{};

    // for (int i = 0; i < stepAllProviders[currentStep].length; i++) {
    //   final val = ref.watch(stepAllProviders[currentStep][i]);
    //   if (val == null ||
    //       (val is String && val.trim().isEmpty) ||
    //       (val is Set && val.isEmpty) ||
    //       (val is List && val.isEmpty) ||
    //       (val is Map && val.isEmpty)) {
    //     unanswered.add(i);
    //   }
    // }

    // print(unanswered);
    // ref.read(unansweredQuestionsProvider.notifier).state = unanswered;

    // if (unanswered.isEmpty) {
    //   counter.state++;
    // }

    // if (counter.state == 5) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => NavigationScreen()));
    // }
  counter.state++;
  
  }
}

class StepContent extends StatelessWidget {
  final int counter;

  const StepContent({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    switch (counter) {
      case 0:
        return RoutineNameView();
      case 1:
        return GoalView();
      case 2:
        return DaysView();
      case 3:
        return RoutineTarget();
      case 4:
        return WorkoutDays();

      default:
        return Center(
          child: Text('Unknown widget'),
        );
    }
  }
}
