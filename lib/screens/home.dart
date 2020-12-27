import 'package:flutter/material.dart';

import '../widgets/chart.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';
import '../widgets/new_transaction.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      amount: 99.99,
      title: "My first spense",
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 9)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 10)),
    ),
    Transaction(
      id: "t2",
      amount: 16.53,
      title: "Weekly groceries",
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = new Transaction(
      id: DateTime.now().toString(),
      amount: txAmount,
      title: txTitle,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_userTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
