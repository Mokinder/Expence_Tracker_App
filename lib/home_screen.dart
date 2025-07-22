import 'package:expence_tracker_app/add_new_expences.dart';
import 'package:expence_tracker_app/chart.dart';
import 'package:expence_tracker_app/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'model/expense_data.dart';


class HomeScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

  List<ExpenseData> registeredExpence= [
    ExpenseData(title: 'Lunch', amount: 70.0, category: Category.food, dateTime: DateTime.now()),
    ExpenseData(title: 'Petrol',amount: 320.0,category: Category.fuel,dateTime: DateTime.now()),
    ExpenseData(title: 'Fruits',amount: 450.0,category: Category.food,dateTime: DateTime.now()),
  ];

  void addExpence(ExpenseData expence){
    setState(() {
      registeredExpence.add(expence);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('New expence added..'),
        duration: const Duration(seconds: 3),
        shape: const StadiumBorder(),
        backgroundColor: Color.fromARGB(234, 345, 34, 36),
      ),
    );
  }

  void _addExpenceItems(){
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context, builder: (cxt) => AddNewExpences(onAddExpence: addExpence),
    );
  }

  void _removeExpenceItem(ExpenseData expence){

    final expenceindex = registeredExpence.indexOf(expence);

    setState(() {
      registeredExpence.remove(expence);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        shape: const StadiumBorder(),
        backgroundColor: Color.fromARGB(234, 345, 34, 36),
        content: Text(' Expence deleted..'),
        action: SnackBarAction(label:'Undo', onPressed: (){
          setState(() {
            registeredExpence.insert(expenceindex, expence);
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child:  Text('No expences found, start adding some expences..'),
    );
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
         title: Text(
           'Flutter Expence Tracker App',
           style: TextStyle(
             color: Colors.white70,
             fontSize: 18.0,
             fontWeight: FontWeight.bold,
           ),
         ),
        actions: [
          IconButton(
              onPressed: _addExpenceItems,
              icon: Icon(
                  Icons.add,
                  size: 26.0,
                 color: Colors.white,
              ),
          ),
        ],
        backgroundColor: Color.fromARGB(235, 15, 3, 67),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                //Color.fromARGB(235, 113, 190, 216),
                Color.fromARGB(235, 168, 206, 211),
                Color.fromARGB(235, 216, 220, 221),
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Chart(expenses: registeredExpence),
            SizedBox(height: 14.0),
            Expanded(
              child: ExpenceList(ep_data: registeredExpence, removeExepnce: _removeExpenceItem),
            ),
          ],
        ),
      ),
    );
  }
}