import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/category_model.dart';

const categoryDbName = 'category-database';

abstract class CategoryDbFunctions{
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
}

class CategoryDb implements CategoryDbFunctions{
  CategoryDb._initial();
  static CategoryDb instance = CategoryDb._initial();

  factory CategoryDb(){
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    // await _categoryDb.add(value);
    await _categoryDb.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUi() async{
    final _allCategories = await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    Future.forEach(_allCategories, (CategoryModel category){
      if(category.type == CategoryType.income){
        incomeCategoryListNotifier.value.add(category);
      }else{
        expenseCategoryListNotifier.value.add(category);
      }
    });
    incomeCategoryListNotifier.notifyListeners();
    expenseCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId) async{
    final _categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    await _categoryDb.delete(categoryId);
    refreshUi();
  }

}