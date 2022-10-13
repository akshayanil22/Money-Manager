import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/model/category_model.dart';

class CustomTransactionTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String trailing;
  final CategoryType type;
  final DateTime date;
  const CustomTransactionTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.trailing,
    required this.type,
    required this.date

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: type==CategoryType.income?Colors.green:Colors.red,radius: 30,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(parseDate(date),textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                // Text('Sep',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
              ],
            ),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),),Text(subTitle,style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),),
              ],
            ),
            Spacer(),
            Text('Rs $trailing',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
          ],
        )
    );
  }

  String parseDate(DateTime date){
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');

    return '${_splitedDate.last} \n ${_splitedDate.first}';
    // return '${date.day}\n ${date.month}';
  }
}
