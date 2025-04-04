import 'dart:math';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.21,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      //가리지 않는 안전한 지점. ex ) front camera
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
        maxWidth: min(MediaQuery.of(context).size.width, 800),
      ),
      builder: (ctr) => NewExpense(addNewExpense: _addNewExpense),
    );
  }

  void _removeExpense(Expense expense) {
    final int idx = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.removeAt(idx);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text('지출이 삭제되었습니다.'), //

        action: SnackBarAction(
          label: 'Undo',

          onPressed: () {
            setState(() {
              _registeredExpenses.insert(idx, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('지출이 없습니다. 지출을 추가하여 시작해보세요!'), //
    );

    if (_registeredExpenses.isNotEmpty) {
      //
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter ExpenseTracker',
          textAlign: TextAlign.start, //
        ),

        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, //
            icon: const Icon(Icons.add),
          ),
          //
        ],
      ),

      //reponsivility
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
