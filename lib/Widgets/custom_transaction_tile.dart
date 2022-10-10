import 'package:flutter/material.dart';

class CustomTransactionTile extends StatelessWidget {
  const CustomTransactionTile({
    Key? key,
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
            CircleAvatar(backgroundColor: Colors.red,radius: 30,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('1',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                Text('Sep',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
              ],
            ),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sep Salary',style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),),Text('Salary',style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),),
              ],
            ),
            Spacer(),
            Text('Rs 1500',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
          ],
        )
    );
  }
}
