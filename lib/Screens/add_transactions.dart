import 'package:flutter/material.dart';

class AddTransactions extends StatelessWidget {
  ValueNotifier<String> groupValue = ValueNotifier('Income');

  ValueNotifier<String> dropdownvalue = ValueNotifier('Item 1');

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  AddTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Money Manager'),elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Purpose',
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          const SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
                hintText: 'Amount',
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: (){},
            child: Row(
              children: const [
                Icon(Icons.calendar_month,color: Colors.blue,),
                Text('Select Date',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          const SizedBox(height: 20,),ValueListenableBuilder(
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
          ValueListenableBuilder(
            valueListenable: dropdownvalue,
            builder: (context,data,_) {
              return DropdownButton(
                // Initial Value
                value: data,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                    dropdownvalue.value = newValue!;
                    dropdownvalue.notifyListeners();
                },
              );
            }
          ),
            const SizedBox(height: 20,),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: Text('Submit')))
        ],),
      ),
    );
  }
}
