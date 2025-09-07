import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';
import 'package:uuid/uuid.dart';



class RoutineModel {
  final String id; 
  final String name;
  final String goal;
  final Map<String, List<WorkoutModel>> workouts;

  RoutineModel({
    String? id,
    required this.name,
    required this.goal,
    required this.workouts,
  }) : id = id ?? const Uuid().v4(); 

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'goal': goal,
        'workouts': workouts.map(
          (day, workoutList) => MapEntry(
            day,
            workoutList.map((w) => w.toJson()).toList(),
          ),
        ),
      };

  factory RoutineModel.fromJson(Map<String, dynamic> json) => RoutineModel(
        id: json['id'],
        name: json['name'],
        goal: json['goal'],
        workouts: (json['workouts'] as Map<String, dynamic>).map(
          (day, workoutList) => MapEntry(
            day,
            (workoutList as List)
                .map((w) => WorkoutModel.fromJson(w))
                .toList(),
          ),
        ),
      );
}

