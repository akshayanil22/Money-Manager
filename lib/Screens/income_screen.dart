import 'package:flutter/material.dart';
import 'package:money_manager/Db/category_db.dart';

import '../model/category_model.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ValueListenableBuilder(
        valueListenable: CategoryDb().incomeCategoryListNotifier,
        builder: (BuildContext context,List<CategoryModel> newList, Widget? _) {
          return newList.isNotEmpty?ListView.separated(
            itemCount: newList.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: Text(
                  newList[index].name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDb.instance.deleteCategory(newList[index].id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ):const Center(child: Text('No Income Category'),);
        }
      ),
    );
  }
}
