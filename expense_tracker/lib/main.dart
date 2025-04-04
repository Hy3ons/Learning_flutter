  import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var KColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 228, 74, 255),
);

var KDarkColorScheme = ColorScheme.fromSeed(
  //어둡게 최적화 해줍니다.
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 34, 34, 34),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    fn,
  ) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: KDarkColorScheme, //

          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: KDarkColorScheme.onPrimaryContainer,
            foregroundColor: KDarkColorScheme.primaryContainer,
          ),

          cardTheme: const CardTheme().copyWith(
            color: KDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: KDarkColorScheme.primaryContainer,
            ),
          ),

          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: KDarkColorScheme.onPrimaryContainer,
              fontSize: 14,
            ),
          ),
        ),

        theme: ThemeData().copyWith(
          colorScheme: KColorScheme,

          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: KColorScheme.onPrimaryContainer,
            foregroundColor: KColorScheme.primaryContainer,
          ),

          cardTheme: const CardTheme().copyWith(
            color: KColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: KColorScheme.primaryContainer,
            ),
          ),

          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: KColorScheme.onPrimaryContainer,
              fontSize: 14,
            ),
          ),
        ),

        themeMode: ThemeMode.system,
        home: const Expenses(), //
      ),
    );
  });
}
