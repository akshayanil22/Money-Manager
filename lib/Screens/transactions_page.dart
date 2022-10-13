import 'package:flutter/material.dart';
import 'package:money_manager/Db/transaction_db.dart';

import '../Widgets/custom_transaction_tile.dart';
import '../model/transaction_model.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ValueListenableBuilder(
          valueListenable: TransactionDb.instance.transactionListNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? _) {
            return ListView.separated(
              itemCount: newList.length,
              itemBuilder: (context, index) => GestureDetector(
                onLongPress: (){
                  TransactionDb.instance.deleteTransaction(newList[index].id!);
                },
                child: CustomTransactionTile(
                  title: newList[index].purpose,
                  subTitle: newList[index].category.name,
                  trailing: newList[index].amount.toString(),
                  type: newList[index].type,
                  date:newList[index].date,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
            );
          }),
    );
  }
}
