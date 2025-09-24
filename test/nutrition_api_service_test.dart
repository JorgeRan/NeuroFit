import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:neurofit_app/features/nutrition/data/api/nutrition_api_service.dart';
import 'package:flutter/material.dart';

// class MockClient extends Mock implements http.Client {}

// void main() {
//   group('NutritionApiService', () {
//     late NutritionApiService apiService;
//     late MockClient mockClient;

//     setUp(() {
//       mockClient = MockClient();
//       apiService = NutritionApiService();
//     });

//     test('Return data if the http call completes successfully', () async {
//       when(
//         mockClient.get(
//           Uri.parse(
//             'https://api.nal.usda.gov/fdc/v1/foods/search?query=banana&api_key=bcbsI0R93wd8Bbhmwq6IeHjNK4ktrBNDxxo8Kkf0&pageSize=1',
//           ),
//         ),
//       ).thenAnswer((_) async => http.Response(
//           jsonEncode({
//             "totalHits": 5165,
//             "currentPage": 1,
//             "totalPages": 5165,
//             "pageList": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
//             "foodSearchCriteria": {
//               "query": "banana",
//               "generalSearchInput": "banana",
//               "pageNumber": 1,
//               "numberOfResultsPerPage": 50,
//               "pageSize": 1,
//               "requireAllWords": false
//             },
//             "foods": [
//               {
//                 "fdcId": 2012128,
//                 "description": "BANANA",
//                 "dataType": "Branded",
//                 "gtinUpc": "016459200441",
//                 "publishedDate": "2021-10-28",
//                 "brandOwner": "Wonder Natural Foods Corp",
//                 "brandName": "BETTER'N PEANUT BUTTER",
//                 "ingredients":
//                     "PEANUTS (AS DEFATTED PEANUT FLOUR, PEANUT BUTTER AND NATURAL PEANUT OILS), PURE WATER, TAPIOCA SYRUP, RICE SYRUP, VEGETABLE GLYCERINE, CANE SUGAR, BANANA, NATURAL COLORS AND FLAVORS, SALT, CALCIUM CARBONATE, LECITHIN, TOCOPHEROL (VITAMIN E), SODIUM ASCORBATE (VITAMIN C).",
//                 "marketCountry": "United States",
//                 "foodCategory": "Nut & Seed Butters",
//                 "modifiedDate": "2018-06-29",
//                 "dataSource": "LI",
//                 "packageWeight": "16 oz/1 lbs/454 g",
//                 "servingSizeUnit": "g",
//                 "servingSize": 32.0,
//                 "householdServingFullText": "2 Tbsp",
//                 "tradeChannels": ["NO_TRADE_CHANNEL"],
//                 "allHighlightFields":
//                     "<b>Ingredients</b>:  SYRUP, RICE SYRUP, VEGETABLE GLYCERINE, CANE SUGAR, <em>BANANA</em>, NATURAL COLORS AND FLAVORS, SALT, CALCIUM",
//                 "score": 1179.1216,
//                 "microbes": [],
//                 "foodNutrients": [
//                   {
//                     "nutrientId": 1003,
//                     "nutrientName": "Protein",
//                     "nutrientNumber": "203",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 12.5,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 600,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035654
//                   },
//                   {
//                     "nutrientId": 1004,
//                     "nutrientName": "Total lipid (fat)",
//                     "nutrientNumber": "204",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 6.25,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 800,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035655,
//                     "percentDailyValue": 3
//                   },
//                   {
//                     "nutrientId": 1005,
//                     "nutrientName": "Carbohydrate, by difference",
//                     "nutrientNumber": "205",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 40.6,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 1110,
//                     "indentLevel": 2,
//                     "foodNutrientId": 26035656,
//                     "percentDailyValue": 4
//                   },
//                   {
//                     "nutrientId": 1008,
//                     "nutrientName": "Energy",
//                     "nutrientNumber": "208",
//                     "unitName": "KCAL",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 312,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 300,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035657
//                   },
//                   {
//                     "nutrientId": 2000,
//                     "nutrientName": "Total Sugars",
//                     "nutrientNumber": "269",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 6.25,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 1510,
//                     "indentLevel": 3,
//                     "foodNutrientId": 26035658
//                   },
//                   {
//                     "nutrientId": 1079,
//                     "nutrientName": "Fiber, total dietary",
//                     "nutrientNumber": "291",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 6.2,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 1200,
//                     "indentLevel": 3,
//                     "foodNutrientId": 26035659,
//                     "percentDailyValue": 8
//                   },
//                   {
//                     "nutrientId": 1087,
//                     "nutrientName": "Calcium, Ca",
//                     "nutrientNumber": "301",
//                     "unitName": "MG",
//                     "derivationCode": "LCCD",
//                     "derivationDescription":
//                         "Calculated from a daily value percentage per serving size measure",
//                     "derivationId": 75,
//                     "value": 125,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 5300,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035660,
//                     "percentDailyValue": 4
//                   },
//                   {
//                     "nutrientId": 1089,
//                     "nutrientName": "Iron, Fe",
//                     "nutrientNumber": "303",
//                     "unitName": "MG",
//                     "derivationCode": "LCCD",
//                     "derivationDescription":
//                         "Calculated from a daily value percentage per serving size measure",
//                     "derivationId": 75,
//                     "value": 1.12,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 5400,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035661,
//                     "percentDailyValue": 2
//                   },
//                   {
//                     "nutrientId": 1093,
//                     "nutrientName": "Sodium, Na",
//                     "nutrientNumber": "307",
//                     "unitName": "MG",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 594,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 5800,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035662,
//                     "percentDailyValue": 8
//                   },
//                   {
//                     "nutrientId": 1104,
//                     "nutrientName": "Vitamin A, IU",
//                     "nutrientNumber": "318",
//                     "unitName": "IU",
//                     "derivationCode": "LCCD",
//                     "derivationDescription":
//                         "Calculated from a daily value percentage per serving size measure",
//                     "derivationId": 75,
//                     "value": 0.0,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 7500,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035663,
//                     "percentDailyValue": 0
//                   },
//                   {
//                     "nutrientId": 1162,
//                     "nutrientName": "Vitamin C, total ascorbic acid",
//                     "nutrientNumber": "401",
//                     "unitName": "MG",
//                     "derivationCode": "LCCD",
//                     "derivationDescription":
//                         "Calculated from a daily value percentage per serving size measure",
//                     "derivationId": 75,
//                     "value": 15.0,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 6300,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035664,
//                     "percentDailyValue": 8
//                   },
//                   {
//                     "nutrientId": 1253,
//                     "nutrientName": "Cholesterol",
//                     "nutrientNumber": "601",
//                     "unitName": "MG",
//                     "derivationCode": "LCCD",
//                     "derivationDescription":
//                         "Calculated from a daily value percentage per serving size measure",
//                     "derivationId": 75,
//                     "value": 0.0,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 15700,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035665,
//                     "percentDailyValue": 0
//                   },
//                   {
//                     "nutrientId": 1257,
//                     "nutrientName": "Fatty acids, total trans",
//                     "nutrientNumber": "605",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 0.0,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 15400,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035666
//                   },
//                   {
//                     "nutrientId": 1258,
//                     "nutrientName": "Fatty acids, total saturated",
//                     "nutrientNumber": "606",
//                     "unitName": "G",
//                     "derivationCode": "LCCD",
//                     "derivationDescription":
//                         "Calculated from a daily value percentage per serving size measure",
//                     "derivationId": 75,
//                     "value": 0.0,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 9700,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035667,
//                     "percentDailyValue": 0
//                   },
//                   {
//                     "nutrientId": 1292,
//                     "nutrientName": "Fatty acids, total monounsaturated",
//                     "nutrientNumber": "645",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 3.12,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 11400,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035668
//                   },
//                   {
//                     "nutrientId": 1293,
//                     "nutrientName": "Fatty acids, total polyunsaturated",
//                     "nutrientNumber": "646",
//                     "unitName": "G",
//                     "derivationCode": "LCCS",
//                     "derivationDescription":
//                         "Calculated from value per serving size measure",
//                     "derivationId": 70,
//                     "value": 3.12,
//                     "foodNutrientSourceId": 9,
//                     "foodNutrientSourceCode": "12",
//                     "foodNutrientSourceDescription":
//                         "Manufacturer's analytical; partial documentation",
//                     "rank": 12900,
//                     "indentLevel": 1,
//                     "foodNutrientId": 26035669
//                   }
//                 ],
//                 "finalFoodInputFoods": [],
//                 "foodMeasures": [],
//                 "foodAttributes": [],
//                 "foodAttributeTypes": [],
//                 "foodVersionIds": []
//               }
//             ],
//             "aggregations": {
//               "dataType": {
//                 "Branded": 5081,
//                 "SR Legacy": 58,
//                 "Survey (FNDDS)": 22,
//                 "Experimental": 2,
//                 "Foundation": 2
//               },
//               "nutrients": {}
//             }
//           }),
//           200));

//       final result = await apiService.fetchNutrition('banana');
//       expect(result['name'], 'banana');
//       expect(result['calories'], 312.0);
//     });

//     test('throws exception on error response', () {
//       when(
//         mockClient.get(
//           Uri.parse(
//             'https://api.calorieninjas.com/v1/nutrition?query=banana',
//           ),
//         ),
//       ).thenAnswer((_) async => http.Response('Not found', 404));

//       expect(() => apiService.fetchNutrients('banana'), throwsException);
//     });
//   });
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final service = NutritionApiService();
  final result = await service.fetchNutrition("banana");
  print("Name: ${result['name']}");
  print("Calories: ${result['calories']}");
  print("Protein: ${result['protein']} g");
  print("Fat: ${result['fat']} g");
  print("Carbs: ${result['carbs']} g");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Check your console for API output")),
      ),
    );
  }
}


