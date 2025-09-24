import 'package:neurofit_app/features/nutrition/data/api/nutrition_api_service.dart';
import 'package:neurofit_app/features/nutrition/data/models/nutrition.dart';

class NutritionRepository {
  final NutritionApiService apiService;

  NutritionRepository({
    required this.apiService,
  });

  Future<Nutrition> getNutritionForIngredient(String ingredient) async {
    final data = await apiService.fetchNutrition(ingredient);
    return Nutrition.fromJson(data);
  }
}
