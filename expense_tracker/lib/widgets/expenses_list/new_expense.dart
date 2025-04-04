import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});

  final void Function(Expense) addNewExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  // String _enteredTitle = '';
  String _categoryHint = "Select Category";
  Category? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  void _showRejectAlertDialog() {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            //
            title: const Text('잘못된 입력입니다.'),
            content: const Text('제목과, 금액, 날짜와 카테고리를 모두 입력했는지 확인해주세요.'),

            actions: [
              //T
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('확인 했습니다.'),
              ),
            ],
          ),
    );
  }

  bool _submitExpenseData() {
    //tryParse는 분석에 실패하면 Null을 반환한다.
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvaild = enteredAmount == null || enteredAmount <= 0;

    //Invalid Input Exception
    if (_titleController.text.trim().isEmpty ||
        amountIsInvaild ||
        _selectedDate == null) {
      _showRejectAlertDialog();
      return false;
    }

    final Expense newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      category: _selectedCategory!,
      date: _selectedDate!,
    );

    widget.addNewExpense(newExpense);
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constrains) {
        final double width = constrains.maxWidth;

        return SizedBox(
          height: double.infinity,
          width: width,

          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, 16 + keyboardSpace),

              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                              label: Text('Title'), //
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,

                                  decoration: InputDecoration(
                                    label: Text('Amount'), //
                                    prefixText: '\$ ',
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      _selectedDate != null
                                          ? formatter.format(
                                            _selectedDate as DateTime,
                                          )
                                          : 'Selected Date',
                                    ),

                                    IconButton(
                                      onPressed: _presentDatePicker,
                                      icon: Icon(Icons.calendar_month),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      // onChanged: _saveTitleInput,
                      controller: _titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        label: Text('Title'), //
                      ),
                    ),

                  if (width < 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              label: Text('Amount'), //
                              prefixText: '\$ ',
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate != null
                                    ? formatter.format(
                                      _selectedDate as DateTime,
                                    )
                                    : 'Selected Date',
                              ),

                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      DropdownButton(
                        hint: Text(_categoryHint),
                        value: _selectedCategory,
                        items:
                            Category.values
                                .map(
                                  (element) => DropdownMenuItem(
                                    value: element,
                                    child: Text(element.name.toUpperCase()), //
                                  ),
                                )
                                .toList(),

                        onChanged: (Category? value) {
                          if (value == null) return;

                          setState(() {
                            _categoryHint = value.name.toUpperCase();
                            _selectedCategory = value;
                          });
                        },
                      ),

                      const Spacer(),

                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'), //
                      ),
                    ],
                  ),
                ],
              ), //
            ),
          ),
        );
      },
    );

    //
  }
}
