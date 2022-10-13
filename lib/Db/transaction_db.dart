import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/model/transaction_model.dart';

import '../model/category_model.dart';

const transactionDbName = 'transaction-database';

abstract class TransactionDbFunctions{
  Future<List<TransactionModel>> getTransaction();
  Future<void> insertTransaction(TransactionModel value);
  Future<void> deleteTransaction(String categoryId);
}

class TransactionDb implements TransactionDbFunctions{
  TransactionDb._initial();
  static TransactionDb instance = TransactionDb._initial();

  factory TransactionDb(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<void> insertTransaction(TransactionModel value) async{
    final _transactionDb = await Hive.openBox<TransactionModel>(transactionDbName);
    await _transactionDb.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<TransactionModel>> getTransaction() async{
    final _transactionDb = await Hive.openBox<TransactionModel>(transactionDbName);
    return _transactionDb.values.toList();

  }

  Future<void> refreshUi() async{
    final _allTransactions = await getTransaction();
    _allTransactions.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_allTransactions);

    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async{
    final _transactionDb = await Hive.openBox<TransactionModel>(transactionDbName);
    await _transactionDb.delete(transactionId);
    refreshUi();
  }

}