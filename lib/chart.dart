import 'package:expence_tracker_app/model/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker_app/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpenseData> expenses;

  List<ExpenceBucket> get buckets {
    return [
      ExpenceBucket.forCategory(expenses, Category.food),
      ExpenceBucket.forCategory(expenses, Category.liesure),
      ExpenceBucket.forCategory(expenses, Category.travel),
      ExpenceBucket.forCategory(expenses, Category.fuel),
      ExpenceBucket.forCategory(expenses, Category.superMarket),
      ExpenceBucket.forCategory(expenses, Category.investment),
      ExpenceBucket.forCategory(expenses, Category.hospital),
      ExpenceBucket.forCategory(expenses, Category.others),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpences > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpences;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpences == 0
                        ? 0
                        : bucket.totalExpences / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    categoryIcons[bucket.category],
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.7),
                  ),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}