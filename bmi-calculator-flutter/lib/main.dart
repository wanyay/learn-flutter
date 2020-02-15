import 'package:flutter/material.dart';
import 'screens/input_page.dart';

void main() => runApp(BMICalculator());
ThemeData primaryThemeData()
{
  return ThemeData(
      primaryColor: Color(0xFF0A0E21),
      scaffoldBackgroundColor: Color(0xFF0A0E21),
      accentColor:  Colors.purple
  );
}
class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: primaryThemeData(),
      home: InputPage(),
    );
  }
}


