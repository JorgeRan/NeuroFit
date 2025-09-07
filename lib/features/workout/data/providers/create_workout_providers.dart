import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';

// final intensityProvider = StateProvider<String>((ref) => '');
// final selectedItemsProvider = StateProvider<Set<String>>((ref) => {});
// final unansweredQuestionsProvider = StateProvider<Set<int>>((ref) => {});

List createWorkoutProvider = [
  workoutNameProvider,
  workoutDescriptionProvider,
  workoutTypeProvider,
  workoutDurationProvider,
  selectedExercisesProvider,
  selectedMuscleGroupsProvider
];

final createdWorkoutProvider = StateProvider<List<WorkoutModel>>(
  (ref) => [],
);

final workoutNameProvider = StateProvider<String>(
  (ref) => '',
);
final workoutDescriptionProvider = StateProvider<String>(
  (ref) => '',
);
final workoutTypeProvider = StateProvider<String>(
  (ref) => 'Strength',
);
final workoutDurationProvider = StateProvider<String>(
  (ref) => '',
);

final selectedMuscleGroupsProvider = StateProvider<List<String>>(
  (ref) => [],
);
final varyBetweenSetsProvider = StateProvider<bool>((ref) => false);

final selectedExercisesProvider =
    StateProvider<List<WorkoutExercise>>((ref) => []);

final allWorkoutsProvider = StateProvider<List<WorkoutModel>>(
  (ref) => [
    WorkoutModel(
      id: '1',
      name: 'Upper Body Workout',
      description: 'Best Upper body workout there is!',
      exercises: [
        WorkoutExercise(
          name: 'Crunches',
          muscleGroup: 'Abs',
          equipment: 'Bodyweight',
          varySets: false,
          sets: [
            SetDetail(weight: 0, reps: 10),
            SetDetail(weight: 0, reps: 10),
            SetDetail(weight: 0, reps: 10),
          ],
        ),
        WorkoutExercise(
          name: 'Overhead Press',
          muscleGroup: 'Shoulders',
          equipment: 'Dumbbells',
          varySets: false,
          sets: [
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
          ],
        ),
        WorkoutExercise(
          name: 'Cable Crossover',
          muscleGroup: 'Chest',
          equipment: 'Cable Machine',
          varySets: false,
          sets: [
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
          ],
        ),
        WorkoutExercise(
          name: 'Decline Barbell Bench Press',
          muscleGroup: 'Back',
          equipment: 'Barbell',
          varySets: false,
          sets: [
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
            SetDetail(weight: 50, reps: 10),
          ],
        ),
      ],
      type: 'Strength',
      duration: '60',
      targetMuscle: ['Abs', 'Shoulders', 'Chest', 'Back'],
    ),
    WorkoutModel(
      id: '2',
      name: 'Leg Day Blast',
      description: 'A lower body-focused workout for strength and endurance.',
      exercises: [
        WorkoutExercise(
          name: 'Squats',
          muscleGroup: 'Legs',
          equipment: 'Barbell',
          varySets: false,
          sets: [
            SetDetail(weight: 100, reps: 8),
            SetDetail(weight: 100, reps: 8),
            SetDetail(weight: 100, reps: 8),
          ],
        ),
        WorkoutExercise(
          name: 'Lunges',
          muscleGroup: 'Glutes',
          equipment: 'Dumbbells',
          varySets: false,
          sets: [
            SetDetail(weight: 30, reps: 12),
            SetDetail(weight: 30, reps: 12),
            SetDetail(weight: 30, reps: 12),
          ],
        ),
        WorkoutExercise(
          name: 'Leg Press',
          muscleGroup: 'Quads',
          equipment: 'Machine',
          varySets: false,
          sets: [
            SetDetail(weight: 180, reps: 10),
            SetDetail(weight: 180, reps: 10),
            SetDetail(weight: 180, reps: 10),
          ],
        ),
        WorkoutExercise(
          name: 'Calf Raises',
          muscleGroup: 'Calves',
          equipment: 'Machine',
          varySets: false,
          sets: [
            SetDetail(weight: 60, reps: 15),
            SetDetail(weight: 60, reps: 15),
            SetDetail(weight: 60, reps: 15),
          ],
        ),
      ],
      type: 'Strength',
      duration: '50',
      targetMuscle: ['Legs', 'Glutes', 'Quads', 'Calves'],
    ),
    WorkoutModel(
      id: '3',
      name: 'Full Body HIIT',
      description:
          'High-intensity interval training to hit every muscle group.',
      exercises: [
        WorkoutExercise(
          name: 'Burpees',
          muscleGroup: 'Full Body',
          equipment: 'Bodyweight',
          varySets: false,
          sets: [
            SetDetail(weight: 0, reps: 15),
            SetDetail(weight: 0, reps: 15),
            SetDetail(weight: 0, reps: 15),
          ],
        ),
        WorkoutExercise(
          name: 'Kettlebell Swings',
          muscleGroup: 'Back',
          equipment: 'Kettlebell',
          varySets: false,
          sets: [
            SetDetail(weight: 40, reps: 20),
            SetDetail(weight: 40, reps: 20),
            SetDetail(weight: 40, reps: 20),
          ],
        ),
        WorkoutExercise(
          name: 'Push-Ups',
          muscleGroup: 'Chest',
          equipment: 'Bodyweight',
          varySets: false,
          sets: [
            SetDetail(weight: 0, reps: 20),
            SetDetail(weight: 0, reps: 20),
            SetDetail(weight: 0, reps: 20),
          ],
        ),
        WorkoutExercise(
          name: 'Mountain Climbers',
          muscleGroup: 'Core',
          equipment: 'Bodyweight',
          varySets: false,
          sets: [
            SetDetail(weight: 0, reps: 30),
            SetDetail(weight: 0, reps: 30),
            SetDetail(weight: 0, reps: 30),
          ],
        ),
      ],
      type: 'HIIT',
      duration: '40',
      targetMuscle: ['Full Body', 'Back', 'Chest', 'Core'],
    ),
  ],
);
