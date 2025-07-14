import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neurofit_app/screens/onboarding_screen.dart';
import 'package:neurofit_app/screens/onboarding/signUp_page.dart';
import 'classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/screens/onboarding/logIn_page.dart';

double elevationButtons = 8;

const Color kWhite = Color(0xFFFFFFFF);

const Color kBlack = Color(0xFF000000);

const Color kBlue = Color(0xFF2563EB);

const Color kLightGrey = Color(0xFFF1F5F9);

const Color kCardBlue = Color(0xFF3B82F6);

const Color kFieldBorder = Color(0xFFD1D5DB);

const Color kTextGrey = Color(0xFF757575);

const Color kWorkoutPageColor = Color(0xFFEBF4FF);

const TextStyle kParagraphText = TextStyle(color: kBlack, fontSize: 15);

const TextStyle kQuestionsText =
    TextStyle(color: kBlack, fontSize: 15, fontWeight: FontWeight.bold);

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
    'images/Bar_icon.png',
  ),
  Image.asset(
    'images/BrainAI_icon.png',
  ),
  Image.asset(
    'images/BookScience_icon.png',
  ),
];

List onboardingTitles = [
  'Basic Info',
  'Health Goals',
  'Fitness Preferences',
  'Food & Diet',
  'Personalization Style',
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
