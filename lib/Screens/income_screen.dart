import 'package:flutter/material.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(itemCount: 10,itemBuilder: (context, index) => Card(child: ListTile(
        leading:const Text("Salary",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        trailing: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.delete,color: Colors.red,),
        ),
      ),),
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
      ),
    );
  }
}
