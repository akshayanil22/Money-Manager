import 'package:flutter/material.dart';

import '../Widgets/custom_transaction_tile.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(itemCount: 10,itemBuilder: (context, index) => CustomTransactionTile(),
      separatorBuilder: (context, index) => SizedBox(height: 15,),
      ),
    );
  }
}

