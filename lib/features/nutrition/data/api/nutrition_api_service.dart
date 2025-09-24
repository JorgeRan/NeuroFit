// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class NutritionApiService {
//   final http.Client client;
//   final String baseUrl;

//   NutritionApiService({
//     required this.client,
//     required this.baseUrl,
//   });

//   Future<Map<String, dynamic>> fetchNutrients(String ingredient) async {
//     final response = await client.get(
//       Uri.parse(baseUrl),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch nutrition data');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class NutritionApiService {
  final String _apiKey = "bcbsI0R93wd8Bbhmwq6IeHjNK4ktrBNDxxo8Kkf0"; 
  final String _baseUrl = "https://api.nal.usda.gov/fdc/v1";

  Future<Map<String, dynamic>> fetchNutrition(String query) async {
    try {
      final searchUrl =
          Uri.parse("$_baseUrl/foods/search?query=$query&pageSize=3&api_key=$_apiKey");

      final searchResponse = await http.get(searchUrl);
      if (searchResponse.statusCode != 200) {
        throw Exception("Food search failed: ${searchResponse.statusCode}");
      }

      final searchData = jsonDecode(searchResponse.body);
      if (searchData["foods"] == null || searchData["foods"].isEmpty) {
        throw Exception("No foods found");
      }
      

      final fdcId = searchData["foods"][2]["fdcId"];

      final detailUrl = Uri.parse("$_baseUrl/food/$fdcId?api_key=$_apiKey");
      final detailResponse = await http.get(detailUrl);

      if (detailResponse.statusCode != 200) {
        throw Exception("Food detail fetch failed: ${detailResponse.statusCode}");
      }

      final detailData = jsonDecode(detailResponse.body);
      

      final nutrients = detailData["foodNutrients"] as List<dynamic>;
      String? name;
      double? calories;
      double? protein;
      double? fat;
      double? carbs;

        if (detailData['brandName'] == null) {
          name = detailData["description"];
        } else { 
          name = detailData["brandName"];
        }
      

      for (var nutrient in nutrients) {
        final name = nutrient['nutrient']["name"];
        final value = nutrient['amount']?.toDouble();
        if (name == "Energy") calories = value;
        if (name == "Protein") protein = value;
        if (name == "Total lipid (fat)") fat = value;
        if (name == "Carbohydrate, by difference") carbs = value;
      }

      return {
        "name": name,
        "calories": calories ?? 0,
        "protein": protein ?? 0,
        "fat": fat ?? 0,
        "carbs": carbs ?? 0,
      };
    } catch (e) {
      throw Exception("Error fetching nutrition data: $e");
    }
  }
}
