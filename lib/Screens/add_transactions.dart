import 'package:flutter/material.dart';
import 'package:money_manager/Db/category_db.dart';
import 'package:money_manager/Db/transaction_db.dart';
import 'package:money_manager/model/category_model.dart';
import 'package:money_manager/model/transaction_model.dart';

class AddTransactions extends StatefulWidget {

  AddTransactions({Key? key}) : super(key: key);

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  DateTime? selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryId;

  final _purposeTextController = TextEditingController();
  final _amountTextController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _purposeTextController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Purpose',
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _amountTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Amount',
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final _selectedDate = await showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                        const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selectedDate == null) {
                  return;
                } else {
                  setState(() {
                    selectedDate = _selectedDate;
                  });
                }
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.blue,
                  ),
                  Text(
                    selectedDate == null ? 'Select Date' : selectedDate
                        .toString(),
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = newValue;
                          _categoryId = null;
                        });
                      },
                    ),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = newValue;
                          _categoryId = null;
                        });
                      },
                    ),
                    Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton(
              hint: const Text('Select Category'),
              value: _categoryId,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: (_selectedCategoryType == CategoryType.income
                  ? CategoryDb().incomeCategoryListNotifier
                  : CategoryDb().expenseCategoryListNotifier)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: (){
                    _selectedCategoryModel = e;
                  },
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (selectedValue) {
                setState(() {
                  _categoryId = selectedValue;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  addTransaction();
                }, child: Text('Submit')))
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextController.text;
    final _amountText = _amountTextController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // if (_categoryId == null) {
    //   return;
    // }

    if(_selectedCategoryModel==null){
      return;
    }
    if (selectedDate == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if(_parsedAmount==null){
      return;
    }

    final _model = TransactionModel(purpose: _purposeText,
        amount: _parsedAmount,
        date: selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!);

    await TransactionDb().insertTransaction(_model);
    Navigator.of(context).pop();
  }
}
