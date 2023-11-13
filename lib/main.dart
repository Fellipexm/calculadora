import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String _displayText = '';
  String _currentValue = ''; // Armazena o número ou operador atual
  String _operation = ''; // Armazena a operação atual (se houver)
  double _num1 = 0;
  double _num2 = 0;
  String _fullOperation = ''; // Armazena a operação completa para exibir

  void _handleButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        _displayText = '';
        _currentValue = '';
        _operation = '';
        _num1 = 0;
        _num2 = 0;
        _fullOperation = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (_currentValue.isNotEmpty) {
          _num1 = double.parse(_currentValue);
          _operation = value;
          _fullOperation = _currentValue + ' ' + _operation;
          _displayText = _fullOperation;
          _currentValue = '';
        }
      } else if (value == '=') {
        if (_operation.isNotEmpty && _currentValue.isNotEmpty) {
          _num2 = double.parse(_currentValue);
          switch (_operation) {
            case '+':
              _displayText = (_num1 + _num2).toString();
              break;
            case '-':
              _displayText = (_num1 - _num2).toString();
              break;
            case '*':
              _displayText = (_num1 * _num2).toString();
              break;
            case '/':
              _displayText = (_num1 / _num2).toString();
              break;
            default:
              _displayText = 'Error';
          }
          _fullOperation = _fullOperation + ' ' + _currentValue + ' = ' + _displayText;
          _operation = '';
          _currentValue = _displayText;
          _num1 = 0;
          _num2 = 0;
        }
      } else {
        _currentValue += value;
        _displayText = _currentValue;
      }
    });
  }

  Widget _buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _handleButtonClick(buttonText),
        style: ElevatedButton.styleFrom(primary: buttonColor),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('                    Calculadora Flutter')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 20, bottom: 10),
            child: Text(
              _fullOperation,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7', Colors.orange),
              _buildButton('8', Colors.orange),
              _buildButton('9', Colors.orange),
              _buildButton('/', Colors.blue),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', Colors.orange),
              _buildButton('5', Colors.orange),
              _buildButton('6', Colors.orange),
              _buildButton('*', Colors.blue),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', Colors.orange),
              _buildButton('2', Colors.orange),
              _buildButton('3', Colors.orange),
              _buildButton('-', Colors.blue),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('C', Colors.red),
              _buildButton('0', Colors.orange),
              _buildButton('=', Colors.blue),
              _buildButton('+', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
