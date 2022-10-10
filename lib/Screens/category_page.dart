import 'package:flutter/material.dart';

import 'expense_screen.dart';
import 'income_screen.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelPadding: const EdgeInsets.all(10),
            controller: _tabController,tabs: const [
          Text('Income'),
          Text('Expense'),
        ]),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [
            IncomeScreen(),
            ExpenseScreen(),
          ]),
        )
      ],
    );
  }
}
