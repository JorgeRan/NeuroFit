
class WorkoutLogModel {
  final String type;
  final int duration; 
  final String intensity;
  final DateTime timestamp;

  WorkoutLogModel({
    required this.type,
    required this.duration,
    required this.intensity,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'duration': duration,
        'intensity': intensity,
        'timestamp': timestamp.toIso8601String(),
      };

  factory WorkoutLogModel.fromJson(Map<String, dynamic> json) => WorkoutLogModel(
        type: json['type'],
        duration: json['duration'],
        intensity: json['intensity'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
