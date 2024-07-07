import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Calculator extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _displayText = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _displayText = '0';
        _firstOperand = 0;
        _secondOperand = 0;
        _operator = '';
      } else if (value == '=') {
        if (_operator.isNotEmpty) {
          _secondOperand = double.tryParse(_displayText) ?? 0;
          switch (_operator) {
            case '+':
              _displayText = (_firstOperand + _secondOperand).toString();
              break;
            case '-':
              _displayText = (_firstOperand - _secondOperand).toString();
              break;
            case '*':
              _displayText = (_firstOperand * _secondOperand).toString();
              break;
            case '/':
              if (_secondOperand != 0) {
                _displayText = (_firstOperand / _secondOperand).toString();
              } else {
                _displayText = 'Error';
              }
              break;
          }
          _operator = '';
        }
      } else if (['+', '-', '*', '/'].contains(value)) {
        _firstOperand = double.tryParse(_displayText) ?? 0;
        _operator = value;
        _displayText = '0';
      } else {
        if (_displayText == '0' || _operator.isNotEmpty) {
          _displayText = value;
        } else {
          _displayText += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _displayText,
                style: const TextStyle(
                    fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('C'),
                    _buildButton('0'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: Colors.blue,
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
