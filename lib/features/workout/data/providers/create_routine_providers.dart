import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/features/workout/logic/models/routine_model.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';

final createRoutineProvider = StateProvider<int>(
  (ref) => 0,
);

final routineNameProvider = StateProvider<String>(
  (ref) => '',
);
final routineGoalProvider = StateProvider<String>((ref) => '');

final workoutDaysPlanProvider = StateProvider<Map<String, List<WorkoutModel>>>(
  (ref) => {},
);

final allRoutinesProvider = StateProvider<List<RoutineModel>>(
  (ref) => [
    RoutineModel(
      id: 'routine1',
      name: 'Full Body Strength',
      goal: 'Strength',
      workouts: {
        'Day 1': [
          WorkoutModel(
            id: 'workout1',
            name: 'Upper Body Blast',
            description: 'Focus on chest, back, and arms',
            type: 'Strength',
            duration: '45 min',
            targetMuscle: ['Chest', 'Back', 'Arms'],
            exercises: [
              WorkoutExercise(
                name: 'Push Ups',
                muscleGroup: 'Chest',
                equipment: 'Bodyweight',
                varySets: false,
                sets: [
                  SetDetail(reps: 12),
                  SetDetail(reps: 10),
                  SetDetail(reps: 8),
                ],
              ),
              WorkoutExercise(
                name: 'Dumbbell Rows',
                muscleGroup: 'Back',
                equipment: 'Dumbbell',
                varySets: true,
                sets: [
                  SetDetail(reps: 12, weight: 20),
                  SetDetail(reps: 10, weight: 25),
                  SetDetail(reps: 8, weight: 30),
                ],
              ),
            ],
          ),
        ],
        'Day 2': [
          WorkoutModel(
            id: 'workout2',
            name: 'Lower Body Strength',
            description: 'Focus on legs and glutes',
            type: 'Strength',
            duration: '40 min',
            targetMuscle: ['Legs', 'Glutes'],
            exercises: [
              WorkoutExercise(
                name: 'Squats',
                muscleGroup: 'Legs',
                equipment: 'Bodyweight',
                varySets: false,
                sets: [
                  SetDetail(reps: 15),
                  SetDetail(reps: 12),
                  SetDetail(reps: 10),
                ],
              ),
              WorkoutExercise(
                name: 'Lunges',
                muscleGroup: 'Legs',
                equipment: 'Dumbbell',
                varySets: true,
                sets: [
                  SetDetail(reps: 12, weight: 15),
                  SetDetail(reps: 10, weight: 20),
                ],
              ),
            ],
          ),
        ],
      },
    ),
    RoutineModel(
      id: 'routine2',
      name: 'Cardio & Endurance',
      goal: 'Endurance',
      workouts: {
        'Day 1': [
          WorkoutModel(
            id: 'workout3',
            name: 'HIIT Session',
            description: 'High-intensity interval training',
            type: 'Endurance',
            duration: '30 min',
            targetMuscle: ['Full Body'],
            exercises: [
              WorkoutExercise(
                name: 'Jumping Jacks',
                muscleGroup: 'Full Body',
                equipment: 'Bodyweight',
                varySets: false,
                sets: [
                  SetDetail(reps: 50),
                  SetDetail(reps: 40),
                ],
              ),
              WorkoutExercise(
                name: 'Burpees',
                muscleGroup: 'Full Body',
                equipment: 'Bodyweight',
                varySets: false,
                sets: [
                  SetDetail(reps: 12),
                  SetDetail(reps: 10),
                ],
              ),
            ],
          ),
        ],
        'Day 2': [
          WorkoutModel(
            id: 'workout4',
            name: 'Endurance Run',
            description: 'Outdoor running for stamina',
            type: 'Endurance',
            duration: '60 min',
            targetMuscle: ['Legs', 'Cardio'],
            exercises: [
              WorkoutExercise(
                name: 'Treadmill Run',
                muscleGroup: 'Legs',
                equipment: 'Treadmill',
                varySets: false,
                sets: [
                  SetDetail(reps: 1, weight: null), // reps=1 for duration-based
                ],
              ),
            ],
          ),
        ],
      },
    ),
  ],
);

