import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  var _loading = true;
  String? _error;
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(dotenv.env['FIREBASE_DB']!, 'shopping-list.json');

    final result = await http.get(url, headers: {});

    if (result.statusCode >= 400) {
      // setState(() {
      //   _error = 'Failed to fetch data. Please try again later.';
      // });
      // return [];

      throw Exception('Failed to fetch grocery items. Please try again.');
    }

    if (result.body == 'null') {
      _loading = false;
      return [];
    }

    final Map<String, dynamic> data = json.decode(result.body);

    _loading = false;
    return [
      ...data.entries.map((value) {
        final category = categories.entries.firstWhere((el) {
          return el.value.name == value.value['category'];
        });

        return GroceryItem(
          id: value.key,
          name: value.value['name'],
          quantity: value.value['quantity'],
          category: category.value,
        );
      }),
    ];

    //error
    // _error = '무언가 잘못 되었습니다! 좀 있다가 다시 시도해주세요!';
    // _loading = false;
  }

  void _addItem() async {
    GroceryItem? grocery = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (grocery == null) return;

    setState(() {
      _loading = false;
      _loadedItems = _loadedItems.then((items) => [...items, grocery]);
    });
  }

  void _removeItem(GroceryItem item) {
    final url = Uri.https(
      dotenv.env['FIREBASE_DB']!,
      'shopping-list/${item.id}.json',
    );

    http.delete(url);

    setState(() {
      _loadedItems = _loadedItems.then((items) {
        return items.where((el) => el.id != item.id).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = Center(child: Text('오른쪽 위 추가 버튼을 눌러 아이템을 추가해 보세요.'));

    // if (_loading) {
    //   //
    //   content = const Center(
    //     child: CircularProgressIndicator(
    //       //
    //     ),
    //   );
    // } else if (_groceryItems.isNotEmpty) {
    //   content = ListView.builder(
    //     itemCount: _groceryItems.length,

    //     itemBuilder: (ctx, index) {
    //       final grocery = _groceryItems[index];

    //       return Dismissible(
    //         key: ValueKey(grocery),
    //         onDismissed: (direction) {
    //           _removeItem(grocery);
    //         },

    //         child: ListTile(
    //           title: Text(grocery.name),
    //           leading: Container(
    //             width: 24,
    //             height: 24,
    //             color: grocery.category.textColor,
    //           ),

    //           trailing: Text('${grocery.quantity}'),
    //         ),
    //       );
    //     },
    //   );
    // }

    // if (_error != null) {
    //   content = Center(child: Text(_error!));
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem, //
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data!.isEmpty) {
            return Center(child: Text('오른쪽 위 추가 버튼을 눌러 아이템을 추가해 보세요.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,

            itemBuilder: (ctx, index) {
              final grocery = snapshot.data![index];

              return Dismissible(
                key: ValueKey(grocery),
                onDismissed: (direction) {
                  _removeItem(grocery);
                },

                child: ListTile(
                  title: Text(grocery.name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: grocery.category.textColor,
                  ),

                  trailing: Text('${grocery.quantity}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
