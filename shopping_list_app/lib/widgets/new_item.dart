import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _fromKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQuantity = 1;
  Category _selectedCategory = categories[Categories.vegetables]!;
  bool _isSending = false;

  void _saveItem() async {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      final url = Uri.https(dotenv.env['FIREBASE_DB']!, 'shopping-list.json');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', //
        },

        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _selectedCategory.name,
        }),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      Navigator.of(context).pop(
        GroceryItem(
          id: resData['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),

                validator: (String? input) {
                  if (input == null ||
                      input.isEmpty ||
                      input.trim().length == 0 ||
                      input.trim().length >= 50) {
                    return "길이가 1 에서 50 사이 이어야만 합니다.";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ), //

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'), //
                      ),

                      keyboardType: TextInputType.number,

                      initialValue: '1',

                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            value.trim().length >= 50 ||
                            int.tryParse(value)! <= 0) {
                          return "길이 50이하, 숫자만 입력해야 합니다.";
                        }

                        return null;
                      },

                      onSaved: (newValue) {
                        _enteredQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  //
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.textColor,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.name),
                              ],
                            ), //
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //
                  TextButton(
                    onPressed: _isSending ? null : () {},
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child:
                        _isSending
                            ? const Row(
                              children: [
                                Text('sending...'),

                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    padding: EdgeInsets.all(6),
                                  ),
                                ),
                              ],
                            )
                            : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ), //
      ),
    );
  }
}
