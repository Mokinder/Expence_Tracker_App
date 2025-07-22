import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, liesure, investment, hospital, superMarket, others , fuel}

const categoryIcons = {
  Category.travel : Icons.train,
  Category.food : Icons.lunch_dining,
  Category.fuel : Icons.local_gas_station,
  Category.hospital: Icons.medical_services,
  Category.investment : Icons.inventory_sharp,
  Category.liesure : Icons.movie,
  Category.superMarket : Icons.shopping_cart_sharp,
  Category.others : Icons.ac_unit
};

class ExpenseData{
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime dateTime;

  String get formattedDate{
    return formatter.format(dateTime);
  }

  ExpenseData({
    required this.title,
    required  this.amount,
    required this.category,
    required this.dateTime,
  }): id = uuid.v4();
}


class ExpenceBucket{
   ExpenceBucket({required this.category, required this.expences});

   ExpenceBucket.forCategory(List<ExpenseData> allExpences, this.category):
       expences = allExpences
           .where((expence)=> expence.category == category)
           .toList();

  final Category category;
  List<ExpenseData> expences;

  double get totalExpences{
    double sum = 0;

    for(final expence in expences){
      sum += expence.amount;
    }
    return sum;
  }

}