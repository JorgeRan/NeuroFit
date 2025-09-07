import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String description;
  final String type; 
  final String duration;
  final List<String> targetMuscle;
  final List<WorkoutExercise> exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.type,
    required this.duration,
    required this.targetMuscle,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'type': type,
        'duration': duration,
        'targetMuscle': targetMuscle,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        exercises: (json['exercises'] as List)
            .map((e) => WorkoutExercise.fromJson(e))
            .toList(),
        type: json['type'],
        duration: json['duration'],
        targetMuscle: List<String>.from(json['targetMuscle']),
      );
}