import 'package:calculadora/widgets/calculadora_btn.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _displayText = '0';

  double _num1 = 0;
  double _num2 = 0;
  double _result = 0;

  String _operator = '';
  String _memoryOperator = '';

  bool _usedOperator = false;
  bool _newNumber = true;

  void _clear() {
    setState(() {
      _displayText = '0';
      _num1 = 0;
      _num2 = 0;
      _result = 0;
      _operator = '';
      _memoryOperator = '';
      _usedOperator = false;
      _newNumber = true;
    });
  }

  void _inputDigit(String digit) {
    setState(() {
      if (_newNumber) {
        _displayText = digit;
        _newNumber = false;
      } else {
        _displayText = _displayText == '0' ? digit : _displayText + digit;
      }
    });
  }

  void _inputOperator(String op) {
    setState(() {
      if (_displayText == 'Error') {
        return;
      }
      _num1 = double.parse(_displayText);
      _operator = op;
      _displayText = '0';
      _usedOperator = true;
      _newNumber = true;
    });
  }

  void _calculate() {
    setState(() {
      if (_displayText == 'Error') {
        return;
      }

      if (!_usedOperator) {
        _num1 = double.parse(_displayText);
        switch (_memoryOperator) {
          case '+':
            _result = _num1 + _num2;
            _displayText = _formatResult(_result);
            break;
          case '-':
            _result = _num1 - _num2;
            _displayText = _formatResult(_result);
            break;
          case '*':
            _result = _num1 * _num2;
            _displayText = _formatResult(_result);
            break;
          case '/':
            if (_num2 != 0) {
              _result = _num1 / _num2;
              _displayText = _formatResult(_result);
            } else {
              _displayText = 'Error';
            }
            break;
        }
      } else {
        _num2 = double.parse(_displayText);
        switch (_operator) {
          case '+':
            _result = _num1 + _num2;
            _displayText = _formatResult(_result);
            break;
          case '-':
            _result = _num1 - _num2;
            _displayText = _formatResult(_result);
            break;
          case '*':
            _result = _num1 * _num2;
            _displayText = _formatResult(_result);
            break;
          case '/':
            if (_num2 != 0) {
              _result = _num1 / _num2;
              _displayText = _formatResult(_result);
            } else {
              _displayText = 'Error';
            }
            break;
        }
      }

      _memoryOperator = _operator == '' ? _memoryOperator : _operator;
      _operator = '';
      _usedOperator = false;
      _newNumber = true;
    });
  }

  void _toggleSign() {
    setState(() {
      if (_displayText == '0') {
        return;
      } else if (_displayText == 'Error') {
        return;
      }
      _result = (double.parse(_displayText) * -1);
      _displayText = _formatResult(_result);
    });
  }

  void _percentage() {
    setState(() {
      if (_displayText == '0') {
        return;
      } else if (_displayText == 'Error') {
        return;
      }
      _displayText = (double.parse(_displayText) / 100).toString();
    });
  }

  void _inputDecimal() {
    setState(() {
      if (_newNumber && _displayText != '0') {
        _displayText = '0.';
        _newNumber = false;
      }
      if (!_displayText.contains('.')) {
        _displayText += '.';
      }
    });
  }

  void _deleteLastDigit() {
    if (_displayText == 'Error') {
      return;
    }
    if (!_newNumber) {
      setState(() {
        _displayText = _displayText.length > 1
            ? _displayText.substring(0, _displayText.length - 1)
            : '0';
      });
    }
  }

  String _formatResult(double result) {
    if (_result % 1 == 0) {
      return _result.toInt().toString();
    } else {
      return _result.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _displayText,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 56,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton(
                          onPressed: _deleteLastDigit,
                          child: const Icon(
                            Icons.backspace,
                            size: 40,
                            color: Color.fromARGB(255, 160, 160, 160),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CalculadoraBtn(
                          text: 'AC',
                          onPressed: _clear,
                          backgroundColor:
                              const Color.fromARGB(255, 160, 160, 160),
                          textColor: Colors.black),
                      CalculadoraBtn(
                          text: '+/-',
                          onPressed: _toggleSign,
                          backgroundColor:
                              const Color.fromARGB(255, 160, 160, 160),
                          textColor: Colors.black),
                      CalculadoraBtn(
                          text: '%',
                          onPressed: _percentage,
                          backgroundColor:
                              const Color.fromARGB(255, 160, 160, 160),
                          textColor: Colors.black),
                      CalculadoraBtn(
                          text: '÷',
                          onPressed: () => _inputOperator('/'),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 159, 10),
                          textColor: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CalculadoraBtn(
                          text: '7',
                          onPressed: () => _inputDigit('7'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '8',
                          onPressed: () => _inputDigit('8'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '9',
                          onPressed: () => _inputDigit('9'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: 'x',
                          onPressed: () => _inputOperator('*'),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 159, 10),
                          textColor: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CalculadoraBtn(
                          text: '4',
                          onPressed: () => _inputDigit('4'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '5',
                          onPressed: () => _inputDigit('5'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '6',
                          onPressed: () => _inputDigit('6'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '-',
                          onPressed: () => _inputOperator('-'),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 159, 10),
                          textColor: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CalculadoraBtn(
                          text: '1',
                          onPressed: () => _inputDigit('1'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '2',
                          onPressed: () => _inputDigit('2'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '3',
                          onPressed: () => _inputDigit('3'),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '+',
                          onPressed: () => _inputOperator('+'),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 159, 10),
                          textColor: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _inputDigit('0'),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(160, 80),
                            backgroundColor:
                                const Color.fromARGB(255, 51, 51, 51),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CalculadoraBtn(
                          text: '.',
                          onPressed: _inputDecimal,
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          textColor: Colors.white),
                      CalculadoraBtn(
                          text: '=',
                          onPressed: _calculate,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 159, 10),
                          textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
