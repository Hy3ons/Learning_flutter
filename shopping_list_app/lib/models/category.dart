import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category {
  const Category(this.name, this.textColor);

  final String name;
  final Color textColor;
}
