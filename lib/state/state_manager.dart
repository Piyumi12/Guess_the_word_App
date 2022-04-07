import 'package:guess_the_word/database/category_provider.dart';
import 'package:riverpod/riverpod.dart';

final categoryListProvider = StateNotifierProvider((ref)=>new CategoryList([]));
final questionCategoryState =StateProvider((ref)=>new Category());
final isTestMode = StateProvider((ref)=>false);
