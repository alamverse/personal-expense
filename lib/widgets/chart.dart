import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;

  Chart(this._transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    int totalDays = 7;
    if (!_transactions.isEmpty) {
      _transactions.sort((a, b) => a.date.compareTo(b.date));
      DateTime initialDate = _transactions[0]
              .date
              .isBefore(DateTime.now().subtract(Duration(days: 7)))
          ? _transactions[0].date
          : DateTime.now().subtract(Duration(days: 7));
      totalDays = DateTime.now().difference(initialDate).inDays + 1;
    }

    return List.generate(totalDays, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < _transactions.length; i++) {
        if (_transactions[i].date.day == weekDay.day &&
            _transactions[i].date.month == weekDay.month &&
            _transactions[i].date.year == weekDay.year) {
          totalSum += _transactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(
            children: [
              ...groupedTransactionValues
                  .map(
                    (data) => ChartBar(
                      label: data['day'],
                      spendingAmount: data['amount'],
                      spendingPctOfTotal: totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending,
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
