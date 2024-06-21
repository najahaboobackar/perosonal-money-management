import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TransactionDBFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDBFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> TransactionlistNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    // TODO: implement addTransaction
    final _transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _transaction_db.put(obj.id, obj);

    throw UnimplementedError();
  }

  Future<void> refresh() async {
    final _list = await getAllTransaction();
    _list.sort((first, second) => first.date.compareTo(second.date));
    TransactionlistNotifier.value.clear();
    TransactionlistNotifier.value.addAll(_list);
    TransactionlistNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    // TODO: implement getAllTransaction
    final _transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transaction_db.values.toList();
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    // TODO: implement deleteTransaction
    final _transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transaction_db.delete(id);
    refresh();
    throw UnimplementedError();
  }
}
