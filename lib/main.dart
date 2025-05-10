import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double size = 0;
  String inputValue = "";
  String calculatedValue = "";
  String operator = '';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width > 600 ? 80 : MediaQuery.of(context).size.width / 6;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                inputValue,
                style: TextStyle(color: Colors.white, fontSize: 60),
              ),
            ),
            Row(
              children: [
                calcButton('7', Colors.white38),
                calcButton('8', Colors.white38),
                calcButton('9', Colors.white38),
                calcButton('/', Colors.orange),
              ],
            ),
            Row(
              children: [
                calcButton('4', Colors.white38),
                calcButton('5', Colors.white38),
                calcButton('6', Colors.white38),
                calcButton('*', Colors.orange),
              ],
            ),
            Row(
              children: [
                calcButton('1', Colors.white38),
                calcButton('2', Colors.white38),
                calcButton('3', Colors.white38),
                calcButton('-', Colors.orange),
              ],
            ),
            Row(
              children: [
                calcButton('0', Colors.white38),
                calcButton('.', Colors.white38),
                calcButton('=', Colors.white38),
                calcButton('+', Colors.orange),
              ],
            ),
            calcButton('Clear', Colors.yellow),
          ],
        ),
      ),
    );
  }

  Widget calcButton(String text, Color bgColor) {
    return InkWell(
      onTap: () {
        setState(() {
          if (text == 'Clear') {
            inputValue = '';
            calculatedValue = '';
            operator = '';
          } else if (text == '+' || text == '-' || text == '*' || text == '/') {
            if (inputValue.isEmpty) return;
            calculatedValue = inputValue;
            inputValue = '';
            operator = text;
          } else if (text == '=') {
            if (calculatedValue.isEmpty || inputValue.isEmpty) return;
            double calc = double.tryParse(calculatedValue) ?? 0;
            double input = double.tryParse(inputValue) ?? 0;
            double result = 0;

            if (operator == '+') {
              result = calc + input;
            } else if (operator == '-') {
              result = calc - input;
            } else if (operator == '*') {
              result = calc * input;
            } else if (operator == '/') {
              result = input == 0 ? 0 : calc / input;
            }

            inputValue = (result == result.toInt())
                ? result.toInt().toString()
                : result.toString();

            // Reset for new operation

            calculatedValue = '';
            operator = '';
          } else {
            inputValue += text;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: EdgeInsets.all(10),
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
