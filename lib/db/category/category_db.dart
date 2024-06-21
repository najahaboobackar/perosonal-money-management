import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/screens/category/income_category.dart';

const CATEGORY_DB_NAME = 'catgory_db';

abstract class CategoryDBfunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDBfunctions {
  CategoryDB._internal();
  //make this class singleton same object
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return CategoryDB.instance;
  }

  ValueNotifier<List<CategoryModel>> IncomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> ExpenseCategoryList = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    // TODO: implement insertCategory
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    // TODO: implement getCategories
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allcategories = await getCategories();
    IncomeCategoryList.value.clear();
    ExpenseCategoryList.value.clear();
    await Future.forEach(_allcategories, (CategoryModel category) {
      if (category.type == CategroryType.income) {
        IncomeCategoryList.value.add(category);
      } else {
        ExpenseCategoryList.value.add(category);
      }
    });
    IncomeCategoryList.notifyListeners();
    ExpenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final category_db = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    category_db.delete(categoryID);
    refreshUI();
    // TODO: implement deleteCategory

    throw UnimplementedError();
  }
}
