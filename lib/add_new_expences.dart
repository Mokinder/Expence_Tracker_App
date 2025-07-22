
import 'package:flutter/material.dart';
import 'package:expence_tracker_app/model/expense_data.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();


class AddNewExpences extends StatefulWidget{
  AddNewExpences({required this.onAddExpence,super.key});

  void Function(ExpenseData expence) onAddExpence;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddNewExpencesState();
  }
}


class _AddNewExpencesState extends State<AddNewExpences>{

  var _titleController = TextEditingController();
  var _amountController = TextEditingController();
  var _categoryController = TextEditingController();
  DateTime ? _selectedDate;
  Category _selectedCategory = Category.liesure;




  void _presentDatePicker() async{
    final now = DateTime.now();
    final f_date = DateTime(now.year-5,now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: f_date, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _SubmitExpenceData(){

    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount<=0;

    if(_titleController.text.trim().isEmpty ||amountIsValid || _selectedDate== null){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Invalid Data'),
        content: Text('Pls enter the valid title, amount, category & date..'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Okay'))
        ],
      ),
      );
      return;
    }

    print(_titleController);
    print(_selectedDate);
    print(_amountController);
    print(_selectedCategory);

    widget.onAddExpence(
        ExpenseData(
            title: _titleController.text,
            category: _selectedCategory,
            dateTime: _selectedDate!,
            amount: enteredAmount
        ),
    );
    Navigator.pop(context);
  }


  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(padding: EdgeInsets.fromLTRB(20, 50, 20,20)),
        TextField(
          controller: _titleController,
          maxLength: 20,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            label: Text('  Title'),
          ),
        ),
        Row(
          children: [
            Expanded(
                child:TextField(
                  controller: _amountController,
                  maxLength: 10,
                  style: TextStyle(fontSize: 14.0) ,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee,size: 14),
                    label: Text('  Amount'),
                  ),
                ),
            ),
            SizedBox(width: 20),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? 'No Date selected': formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                )
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text('Category :',style: TextStyle(fontSize: 14),),
            SizedBox(width: 15),
            DropdownButton(
              value: _selectedCategory,
                items: Category.values.
                map(
                      (categoryIcons) =>
                          DropdownMenuItem(
                            value: categoryIcons,
                            child: Text(categoryIcons.name.toUpperCase()),
                          ),
                ).toList() ,
                onChanged: (value){
                  print(value);
                  setState(() {
                    if(value == null){
                      return;
                    }
                    _selectedCategory = value;
                  });
                }
            ),
          ],
        ),
        SizedBox(height: 50),
        Row(
          children: [
            SizedBox(width: 40),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            SizedBox(width: 140),
            ElevatedButton(
                onPressed: _SubmitExpenceData,
                child: Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}

//SizedBox(width: 20),
//             Text('Selected Date : $_selectedDate'),