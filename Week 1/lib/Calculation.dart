import 'package:flutter/material.dart';
import 'ResultDisplay.dart';
import 'Buttons.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  double? width;
  double? result;
  double? firstOperand;
  var operator;
  double? secondOperand;

  numberPressed(int number) {
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number as double?;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number as double?;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number') as double?;
        return;
      }
      if (secondOperand == null) {
        secondOperand = number as double?;
        return;
      }
      secondOperand = int.parse('$secondOperand$number') as double?;
    });
  }

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }

  Widget _getButton(
      {required String text,
      required VoidCallback onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: (width)! / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = (firstOperand)! + (secondOperand)!;
          break;
        case '-':
          result = (firstOperand)! - (secondOperand)!;
          break;
        case '*':
          result = (firstOperand)! * (secondOperand)!;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = ((firstOperand)! / (secondOperand)!);
          break;
      }
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width / 1.04;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ResultDisplay(text1: _getDisplayText()),
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Row(
              children: [
                _getButton(text: '7', onTap: () => numberPressed(7)),
                _getButton(text: '8', onTap: () => numberPressed(8)),
                _getButton(text: '9', onTap: () => numberPressed(9)),
                _getButton(
                    text: 'x',
                    onTap: () => operatorPressed('*'),
                    backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
              ],
            ),
            Row(
              children: [
                _getButton(text: '4', onTap: () => numberPressed(4)),
                _getButton(text: '5', onTap: () => numberPressed(5)),
                _getButton(text: '6', onTap: () => numberPressed(6)),
                _getButton(
                    text: '/',
                    onTap: () => operatorPressed('/'),
                    backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
              ],
            ),
            Row(
              children: [
                _getButton(text: '1', onTap: () => numberPressed(1)),
                _getButton(text: '2', onTap: () => numberPressed(2)),
                _getButton(text: '3', onTap: () => numberPressed(3)),
                _getButton(
                    text: '+',
                    onTap: () => operatorPressed('+'),
                    backgroundColor: Color.fromRGBO(220, 220, 220, 1))
              ],
            ),
            Row(
              children: [
                _getButton(
                    text: '=',
                    onTap: calculateResult,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white),
                _getButton(text: '0', onTap: () => numberPressed(0)),
                _getButton(
                    text: 'C',
                    onTap: clear,
                    backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
                _getButton(
                    text: '-',
                    onTap: () => operatorPressed('-'),
                    backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
              ],
            )
          ],
        ),
      )
    ]);
  }
}
