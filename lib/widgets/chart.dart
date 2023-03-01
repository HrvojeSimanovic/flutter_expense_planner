import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      // for (var i = 0; i < recentTransactions.length; i++) {
      //   if (recentTransactions[i].date.day == weekDay.day &&
      //       recentTransactions[i].date.month == weekDay.month &&
      //       recentTransactions[i].date.year == weekDay.year) {
      //     totalSum += recentTransactions[i].amount;
      //   }
      // }

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'dayTotal': totalSum,
      };
    }).reversed.toList();
  }

  double get totalWeek {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item['dayTotal'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...groupTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'],
                    data['dayTotal'],
                    totalWeek == 0.0 ? 0.0 : data['dayTotal'] / totalWeek,
                  ),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
