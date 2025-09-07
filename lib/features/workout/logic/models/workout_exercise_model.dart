class WorkoutExercise {
  final String name;
  final String muscleGroup;
  final String equipment;
  late bool varySets;
  final List<SetDetail> sets;

  WorkoutExercise({
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.varySets,
    required this.sets,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'muscleGroup': muscleGroup,
        'equipment': equipment,
        'varySets': varySets,
        'sets': sets.map((set) => set.toJson(equipment)).toList(),
      };

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      WorkoutExercise(
        name: json['name'],
        muscleGroup: json['muscleGroup'],
        equipment: json['equipment'],
        varySets: json['varySets'],
        sets: (json['sets'] as List)
            .map((s) => SetDetail.fromJson(s))
            .toList(),
      );
}

class SetDetail {
  late int reps;
  late double? weight; 

  SetDetail({
    required this.reps,
    this.weight,
  });

  Map<String, dynamic> toJson(String equipment) => {
        'reps': reps,
        'weight': equipment == 'Bodyweight' ? null : weight,
      };

  factory SetDetail.fromJson(Map<String, dynamic> json) => SetDetail(
        reps: json['reps'],
        weight: json['weight']?.toDouble(),
      );
}