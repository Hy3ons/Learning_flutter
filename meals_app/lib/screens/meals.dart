import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.list});

  final String? title;
  final List<Meal> list;

  void _onClickCard(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealDetailsScreen(meal: meal);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: list.length,

      itemBuilder: (ctx, idx) {
        return MealItem(
          meal: list[idx],

          onClickCard: () {
            _onClickCard(context, list[idx]);
          },
        );
      },
    );

    if (list.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, //

          children: [
            Text(
              '아무 것도 없네요!!',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Colors.white),
            ), //

            const SizedBox(height: 16),

            Text(
              '다른 카테고리를 선택해 보세요!',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!), //
      ),

      body: content,
    );
  }
}
