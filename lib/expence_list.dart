
import 'package:expence_tracker_app/expence_item.dart';
import 'package:expence_tracker_app/model/expense_data.dart';
import 'package:flutter/cupertino.dart';

class ExpenceList extends StatelessWidget{
  ExpenceList({super.key, required this.ep_data, required this.removeExepnce});

  List<ExpenseData> ep_data;

  void Function(ExpenseData expence) removeExepnce;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: ep_data.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed:
            (direction) => removeExepnce(ep_data[index]),
          key: ValueKey(ep_data[index]),
          child: ExpenceItem(ep_data[index]),
      ),
        //Text(ep_data[index].category.name),
    );
  }
}