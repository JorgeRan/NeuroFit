import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/features/nutrition/data/models/nutrition.dart';
import 'package:neurofit_app/features/nutrition/data/repositories/nutrition_repository.dart';

class NutritionState {
  final Nutrition? nutrition;
  final bool isLoading;
  final String? error;

  NutritionState({
    this.nutrition,
    this.isLoading = false,
    this.error,
  });

  NutritionState copyWith({
    Nutrition? nutrition,
    bool? isLoading,
    String? error,
  }) {
    return NutritionState(
      nutrition: nutrition ?? this.nutrition,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final nutritionRepositoryProvider = Provider<NutritionRepository>(
  (ref) => throw UnimplementedError(),
);

class NutritionNotifier extends StateNotifier<NutritionState> {
  final NutritionRepository repository;

  NutritionNotifier(this.repository) : super(NutritionState());

  Future<void> fetchNutrition(String ingredient) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await repository.getNutritionForIngredient(ingredient);
      state = state.copyWith(nutrition: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final nutritionProvider =
    StateNotifierProvider<NutritionNotifier, NutritionState>(
  (ref) {
    final repo = ref.watch(nutritionRepositoryProvider);
    return NutritionNotifier(repo);
  },
);
