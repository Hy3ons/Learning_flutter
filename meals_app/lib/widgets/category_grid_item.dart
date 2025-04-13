import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.tapped,
  });

  final Category category;
  final void Function() tapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapped,

      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        padding: EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55 * 255),
              category.color.withValues(alpha: 0.9 * 255),
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), //
        ),

        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
