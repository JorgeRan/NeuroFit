
class WorkoutLog {
  final String type;
  final int duration; 
  final String intensity;
  final DateTime timestamp;

  WorkoutLog({
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

  factory WorkoutLog.fromJson(Map<String, dynamic> json) => WorkoutLog(
        type: json['type'],
        duration: json['duration'],
        intensity: json['intensity'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
