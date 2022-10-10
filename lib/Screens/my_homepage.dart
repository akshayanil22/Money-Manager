import 'package:flutter/material.dart';
import 'package:money_manager/Screens/add_transactions.dart';
import 'package:money_manager/Screens/category_page.dart';
import 'package:money_manager/Screens/transactions_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  ValueNotifier<String> groupValue = ValueNotifier('Income');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xffefefef),
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
        elevation: 0,
      ),
      body:
          _selectedIndex == 0 ? const TransactionsPage() : const CategoryPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), label: 'Transactions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Category'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedIndex == 0) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransactions(),));
          } else {
            addCategory();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  void addCategory(){
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Category',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Category Name',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                  valueListenable: groupValue,
                  builder: (context,data,_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'Income',
                              groupValue: data,
                              onChanged: (value) {
                                groupValue.value = value!;
                              },
                            ),
                            const Text('Income'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'Expense',
                              groupValue: data,
                              onChanged: (value) {
                                  groupValue.value = value!;
                              },
                            ),
                            Text('Expense'),
                          ],
                        ),
                      ],
                    );
                  }
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

