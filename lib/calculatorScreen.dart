// calculator_page.dart
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _inputValue = '0';
  double _result = 0;
  String _operator = '';
  bool _isOperatorPressed = false;

  void _onDigitPressed(String digit) {
    setState(() {
      if (_inputValue == '0' || _isOperatorPressed) {
        _inputValue = digit;
        _isOperatorPressed = false;
      } else {
        _inputValue += digit;
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_operator.isNotEmpty) {
        _calculateResult();
      }
      _result = double.parse(_inputValue);
      _operator = operator;
      _isOperatorPressed = true;
    });
  }

  void _onEqualsPressed() {
    setState(() {
      _calculateResult();
      _operator = '';
    });
  }

  void _onClearPressed() {
    setState(() {
      _inputValue = '0';
      _result = 0;
      _operator = '';
      _isOperatorPressed = false;
    });
  }

  void _calculateResult() {
    switch (_operator) {
      case '+':
        _result += double.parse(_inputValue);
        break;
      case '-':
        _result -= double.parse(_inputValue);
        break;
      case '*':
        _result *= double.parse(_inputValue);
        break;
      case '/':
        if (double.parse(_inputValue) != 0) {
          _result /= double.parse(_inputValue);
        } else {
          _inputValue = 'Error';
        }
        break;
    }
    _inputValue = _result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _inputValue,
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButtonItem('7'),
                calculatorButtonItem('8'),
                calculatorButtonItem('9'),
                calculatorButtonItem('/'),
              ],
            ), 
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButtonItem('4'),
                calculatorButtonItem('5'),
                calculatorButtonItem('6'),
                calculatorButtonItem('*'),
              ],
            ),
            SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButtonItem('1'),
                calculatorButtonItem('2'),
                calculatorButtonItem('3'),
                calculatorButtonItem('-'),
              ],
            ),
           const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButtonItem('0'),
                calculatorButtonItem('C', textColor: Colors.red),
                calculatorButtonItem('=', textColor: Colors.green),
                calculatorButtonItem('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget calculatorButtonItem(String text, {Color textColor = Colors.black}) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'C') {
          _onClearPressed();
        } else if (text == '=') {
          _onEqualsPressed();
        } else if (text == '+' || text == '-' || text == '*' || text == '/') {
          _onOperatorPressed(text);
        } else {
          _onDigitPressed(text);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          color: textColor,
        ),
      ),
    );
  }
}
