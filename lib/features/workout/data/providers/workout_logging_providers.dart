import 'package:flutter_riverpod/flutter_riverpod.dart';


final intensityProvider = StateProvider<String>((ref) => '');
final selectedItemsProvider = StateProvider<Set<String>>((ref) => {});
final unansweredQuestionsProvider = StateProvider<Set<int>>((ref) => {});
