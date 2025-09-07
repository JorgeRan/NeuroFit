import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neurofit_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:neurofit_app/features/auth/presentation/screens/signUp_screen.dart';
import '../../shared/presentation/classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/features/auth/presentation/screens/login_screen.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';

double elevationButtons = 8;

const Color kNormalBlue = Colors.blue;

const Color kWhite = Color(0xFFFFFFFF);

const Color kBlack = Color(0xFF000000);

const Color kBlue = Color(0xFF2563EB);

const Color kGreen = Colors.green;

const Color kButtonGrey = Color(0xFFE5E7EB);

const Color kLightGrey = Color(0xFFF1F5F9);

const Color kCardBlue = Color(0xFF3B82F6);

const Color kFieldBorder = Color(0xFFD1D5DB);

const Color kDarkGrey = Color(0xFF1f2937);

const Color kGreyChipColor = Color.fromARGB(255, 219, 221, 222);

const Color kTextGrey = Color(0xFF757575);

const Color kWorkoutPageColor = Color(0xFFEBF4FF);

const Color kRed = Colors.red;

const TextStyle kParagraphText = TextStyle(color: kBlack, fontSize: 15);

const TextStyle kQuestionsText = TextStyle(
  color: kBlack,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const TextStyle kScreenTitle = TextStyle(
  color: kBlack,
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

const TextStyle kPageTitle = TextStyle(
  color: kWhite,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const TextStyle kTitleCard = TextStyle(
  color: kBlack,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

TextStyle kAppName = GoogleFonts.sourceSerif4(
  color: kBlue,
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

TextStyle kNormalText = TextStyle(
  color: kBlack,
  fontWeight: FontWeight.normal,
  fontSize: 18,
);

const kContainerElevation = [
  BoxShadow(
    color: Colors.black26, 
    blurRadius: 4, 
    offset: Offset(0, 2), 
  ),
];

const List onboardingCardHeaders = [
  'Track Your Health',
  'Smart AI Suggestions',
  'Science You Can Trust',
];

const List onboardingCardBodies = [
  'Sync sleep, hear rate, and activity from Apple Health or Google Fit.',
  'Reinforcement learning tailors tips to your habits.',
  'Powered by medical research using RAG from real health sources.',
];

List onboardingCardIcons = [
  Image.asset(
    'assets/images/Bar_icon.png',
  ),
  Image.asset(
    'assets/images/BrainAI_icon.png',
  ),
  Image.asset(
    'assets/images/BookScience_icon.png',
  ),
];

List onboardingTitles = [
  'Basic Info',
  'Health Goals',
  'Fitness Preferences',
  'Food & Diet',
  'Personalization Style',
];

List createWorkoutTitles = [
  'Workout Information',
  'Select Target Muscles',
  'Add Exercises',
  'Review & Save',
];
List createRoutineTitles = [
  'Name your routine',
  'What\'s your goal?',
  'How many days per week?',
  'Target muscle groups',
  'Plan your workout days',
];

final List<Map<String, String>> activityLevels = [
  {
    'title': 'Sedentary',
    'description': 'Little or no physical activity',
    'value': 'sedentary',
  },
  {
    'title': 'Lightly Active',
    'description': 'Light exercise 1–3 days/week',
    'value': 'light',
  },
  {
    'title': 'Moderately Active',
    'description': 'Moderate exercise 3–5 days/week',
    'value': 'moderate',
  },
  {
    'title': 'Very Active',
    'description': 'Intense exercise 6+ days/week or physical job',
    'value': 'active',
  },
];

final List<Map<String, String>> fitnessGoals = [
  {
    'title': 'Strength',
    'description': 'Focus on increasing muscle strength and power',
    'value': 'Strength',
  },
  {
    'title': 'Hypertrophy',
    'description': 'Focus on increasing muscle size',
    'value': 'Hypertrophy',
  },
  {
    'title': 'Endurance',
    'description': 'Focus on improving stamina and cardiovascular fitness',
    'value': 'Endurance',
  },
  {
    'title': 'Weight Loss',
    'description': 'Focus on reducing body fat and losing weight',
    'value': 'Weight Loss',
  },
  {
    'title': 'General Fitness',
    'description': 'Focus on overall health and maintaining fitness',
    'value': 'General Fitness',
  },
];

final List<LabelIconClass> goalFilter = [
  LabelIconClass(label: "Improve sleep quality", icon: Icons.bedtime),
  LabelIconClass(
      label: "Reduce stress and anxiety", icon: Icons.self_improvement),
  LabelIconClass(
      label: "Increase physical activity", icon: Icons.directions_walk),
  LabelIconClass(label: "Lose weight / body fat", icon: Icons.monitor_weight),
  LabelIconClass(
      label: "Build muscle / gain strength", icon: Icons.fitness_center),
  LabelIconClass(label: "Improve endurance / cardio", icon: Icons.favorite),
  LabelIconClass(label: "Eat healthier", icon: Icons.restaurant),
  LabelIconClass(label: "Boost focus and energy", icon: Icons.bolt),
  LabelIconClass(
      label: "Track and manage my health", icon: Icons.health_and_safety),
  LabelIconClass(label: "General wellness", icon: Icons.wb_sunny),
];

final List<LabelClass> fitnessFilter = [
  LabelClass(label: 'Beginner'),
  LabelClass(label: 'Intermediate'),
  LabelClass(label: 'Advanced'),
];

final List<LabelIconClass> workoutFilter = [
  LabelIconClass(label: 'Strength training', icon: Icons.fitness_center),
  LabelIconClass(label: 'Cardio', icon: Icons.favorite),
  LabelIconClass(label: 'Yoga/Pilates	', icon: Icons.self_improvement),
  LabelIconClass(label: 'HIIT', icon: Icons.flash_on),
  LabelIconClass(label: 'Walking', icon: Icons.directions_walk),
  LabelIconClass(label: 'Running', icon: Icons.directions_run),
  LabelIconClass(label: 'Cycling', icon: Icons.directions_bike),
  LabelIconClass(label: 'Mobility/flexibility	', icon: Icons.accessibility_new),
  LabelIconClass(label: 'Mindfulness', icon: Icons.spa),
  LabelIconClass(label: 'Other', icon: Icons.more_horiz),
];

final List<LabelIconClass> equipmentFilter = [
  LabelIconClass(label: 'None / Bodyweight only	', icon: Icons.accessibility),
  LabelIconClass(label: 'Dumbbells', icon: Icons.sports_handball),
  LabelIconClass(
      label: 'Resistance bands	', icon: Icons.settings_input_component),
  LabelIconClass(label: 'Barbell / rack	', icon: Icons.fitness_center),
  LabelIconClass(label: 'Kettlebells	', icon: Icons.sports_kabaddi),
  LabelIconClass(
      label: 'Machines / gym access	', icon: Icons.home_repair_service),
  LabelIconClass(label: 'Cardio machines	', icon: Icons.directions_bike),
  LabelIconClass(label: 'Yoga mat / blocks	', icon: Icons.self_improvement),
  LabelIconClass(label: 'Other', icon: Icons.more_horiz),
];

final List<LabelClass> dietFilter = [
  LabelClass(label: 'No preference'),
  LabelClass(label: 'High protein'),
  LabelClass(label: 'Low carb'),
  LabelClass(label: 'Low fat'),
  LabelClass(label: 'Keto'),
  LabelClass(label: 'Vegan'),
  LabelClass(label: 'Vegetarian'),
  LabelClass(label: 'Pescatarian'),
  LabelClass(label: 'Mediterranean'),
  LabelClass(label: 'Intermittent fasting'),
  LabelClass(label: 'Other'),
];

final List<LabelClass> calorieFilter = [
  LabelClass(label: 'Yes, I have one'),
  LabelClass(label: 'No'),
  LabelClass(label: 'Suggest one for me'),
];

final List<LabelClass> remindersFilter = [
  LabelClass(label: 'Once a day'),
  LabelClass(label: 'A few times per week'),
  LabelClass(label: 'Only when necessary'),
  LabelClass(label: 'Never'),
];

final List<LabelClass> challengeFilter = [
  LabelClass(label: 'Staying consistent'),
  LabelClass(label: 'Finding motivation'),
  LabelClass(label: 'Managing stress or anxiety'),
  LabelClass(label: 'Lack of time'),
  LabelClass(label: 'Lack of knowledge'),
  LabelClass(label: 'Sticking to healthy eating'),
  LabelClass(label: 'Getting enouch sleep'),
  LabelClass(label: 'Other'),
];

final List<Map<String, String>> supportTone = [
  {
    'title': 'Friendly',
    'description': 'Supportive, casual nudges ("You\'ve got this!")',
    'value': 'friendly',
  },
  {
    'title': 'Scientific',
    'description': 'Facts, studies, and logic-backend suggestions',
    'value': 'scientific',
  },
  {
    'title': 'Challenging',
    'description': 'Motivational, "push me harder" tone',
    'value': 'challenging',
  },
  {
    'title': 'Mindful',
    'description': 'Calming, encouraging awareness-based support',
    'value': 'mindful',
  },
  {
    'title': 'Playful',
    'description': 'Gamified, fun, lighthearted tone',
    'value': 'playful',
  },
  {
    'title': 'Minimal',
    'description': 'Only essential notifications',
    'value': 'minimal',
  },
  {
    'title': 'Other',
    'description': 'I’d prefer a different style (you can describe it later)',
    'value': 'other',
  },
];

final List<MapEntry<StateProvider, dynamic>> resettableProviders = [
  MapEntry(selectedAgeProvider, ''),
  MapEntry(selectedHeightProvider, ''),
  MapEntry(selectedWeightProvider, ''),
  MapEntry(selectedActivityLevelProvider, ''),
  MapEntry(selectedHealthGoalsProvider, <String>{}),
  MapEntry(selectedFitnessLevelProvider, ''),
  MapEntry(selectedWorkoutTypesProvider, <String>{}),
  MapEntry(selectedEquipmentProvider, <String>{}),
  MapEntry(selectedDietsProvider, <String>{}),
  MapEntry(calorieGoalChoiceProvider, ''),
  MapEntry(selectedChallengeProvider, ''),
  MapEntry(selectedReminderProvider, ''),
  MapEntry(selectedSupportProvider, <String>{}),
];

final signUpProviders = [
  signUpEmail,
  signUpPassword,
  firstName,
  lastName,
];
final signInProviders = [
  signInEmail,
  signInPassword,
];

final stepAllProviders = [
  step1Providers,
  step2Providers,
  step3Providers,
  step4Providers,
  step5Providers,
];

final step1Providers = [
  selectedAgeProvider,
  selectedGenderProvider,
  selectedHeightProvider,
  selectedWeightProvider,
];

final step2Providers = [
  selectedActivityLevelProvider,
  selectedHealthGoalsProvider,
];

final step3Providers = [
  selectedFitnessLevelProvider,
  selectedWorkoutTypesProvider,
  selectedEquipmentProvider,
];

final step4Providers = [
  selectedDietsProvider,
  selectedCalorieChoiceProvider,
];

final step5Providers = [
  selectedChallengeProvider,
  selectedReminderProvider,
  selectedSupportProvider,
];

const Map<String, Color> muscleGroupColors = {
  'Chest': Color.fromARGB(255, 227, 145, 145),
  'Back': Color.fromARGB(255, 143, 200, 246),
  'Shoulders': Color.fromARGB(255, 249, 213, 159),
  'Biceps': Color.fromARGB(255, 167, 237, 170),
  'Triceps': Color.fromARGB(255, 239, 180, 250),
  'Abs': Color.fromARGB(255, 248, 193, 176),
  'Quads': Color.fromARGB(255, 167, 247, 239),
  'Hamstrings': Color.fromARGB(255, 210, 188, 249),
  'Glutes': Color.fromARGB(255, 153, 136, 130),
  'Calves': Color.fromARGB(255, 204, 233, 247),
  'Lower Back': Color.fromARGB(171, 79, 194, 247),
  'Obliques': Color.fromARGB(171, 255, 214, 79),
  'Delts': Color.fromARGB(196, 121, 135, 203),
  'Forearms': Color.fromARGB(194, 77, 105, 243),
};

const Map<String, Color> trainingGoalColors = {
  'Strength': Color.fromARGB(255, 247, 190, 128),
  'Hypertrophy': Color.fromARGB(255, 255, 160, 160),
  'Endurance': Color.fromARGB(255, 141, 205, 248),
  'Weight Loss': Color.fromARGB(146, 226, 124, 212),
  'General Fitness': Color.fromARGB(255, 138, 217, 170),
};

final List<WorkoutExercise> chestExercises = [
  WorkoutExercise(
    name: 'Barbell Bench Press',
    muscleGroup: 'Chest',
    equipment: 'Barbell',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Incline Dumbbell Press',
    muscleGroup: 'Chest',
    equipment: 'Dumbbells',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Chest Fly',
    muscleGroup: 'Chest',
    equipment: 'Dumbbells',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Push-Up',
    muscleGroup: 'Chest',
    equipment: 'Bodyweight',
    varySets: false,
    sets: [
      SetDetail(weight: 0, reps: 10),
      SetDetail(weight: 0, reps: 10),
      SetDetail(weight: 0, reps: 10),
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
    muscleGroup: 'Chest',
    equipment: 'Barbell',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Incline Barbell Bench Press',
    muscleGroup: 'Chest',
    equipment: 'Barbell',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Pec Deck Machine',
    muscleGroup: 'Chest',
    equipment: 'Machine',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Dips (Chest Focus)',
    muscleGroup: 'Chest',
    equipment: 'Bodyweight',
    varySets: false,
    sets: [
      SetDetail(weight: 0, reps: 10),
      SetDetail(weight: 0, reps: 10),
      SetDetail(weight: 0, reps: 10),
    ],
  ),
  WorkoutExercise(
    name: 'Single Arm Dumbbell Press',
    muscleGroup: 'Chest',
    equipment: 'Dumbbell',
    varySets: false,
    sets: [
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
      SetDetail(weight: 50, reps: 10),
    ],
  ),
];
