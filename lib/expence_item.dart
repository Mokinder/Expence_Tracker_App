

import 'package:expence_tracker_app/model/expense_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ExpenceItem extends StatelessWidget{

  ExpenceItem(this.expenseData,{super.key});

  final ExpenseData expenseData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenseData.title,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.currency_rupee,size: 18,),
                Text('${expenseData.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenseData.category]),
                    //Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 5),
                    Text('${expenseData.formattedDate}'),

                  ],
                )
              ],
            )
          ],
        )
      ),

    );
  }
}

//  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//           color: Color.fromARGB(234, 203, 236, 192),
//           shadowColor: Colors.black26,
//           margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),,