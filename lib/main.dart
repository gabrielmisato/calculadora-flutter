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
  String displayText = '0';

  double num1 = 0;
  double num2 = 0;
  double result = 0;
  String operator = '';

  bool wipeDisplay = false;

  void _clear() {
    setState(() {
      displayText = '0';
      num1 = 0;
      num2 = 0;
      operator = '';
      wipeDisplay = false;
    });
  }

  void _inputDigit(String digit) {
    setState(() {
      if (wipeDisplay) {
        displayText = digit;
        wipeDisplay = false;
      } else {
        displayText = displayText == '0' ? digit : displayText + digit;
      }
    });
  }

  void _inputOperator(String op) {
    setState(() {
      if (displayText == 'Error') {
        return;
      }
      num1 = double.parse(displayText);
      operator = op;
      displayText = '0';
      wipeDisplay = true;
    });
  }

  void _calculate() {
    setState(() {
      if (displayText == 'Error') {
        return;
      }
      num2 = double.parse(displayText);

      switch (operator) {
        case '+':
          result = num1 + num2;
          displayText = _formatResult(result);
          break;
        case '-':
          result = num1 - num2;
          displayText = _formatResult(result);
          break;
        case '*':
          result = num1 * num2;
          displayText = _formatResult(result);
          break;
        case '/':
          if (num2 != 0) {
            result = num1 / num2;
            displayText = _formatResult(result);
          } else {
            displayText = 'Error';
          }
          break;
      }

      operator = '';
      wipeDisplay = true;
    });
  }

  void _toggleSign() {
    setState(() {
      if (displayText == '0') {
        return;
      }
      result = (double.parse(displayText) * -1);
      displayText = _formatResult(result);
    });
  }

  void _percentage() {
    setState(() {
      if (displayText == '0') {
        return;
      } else if (displayText == 'Error') {
        return;
      }
      displayText = (double.parse(displayText) / 100).toString();
    });
  }

  void _inputDecimal() {
    setState(() {
      if (wipeDisplay && displayText != '0') {
        displayText = '0.';
        wipeDisplay = false;
      }
      if (!displayText.contains('.')) {
        displayText += '.';
      }
    });
  }

  String _formatResult(double result) {
    if (result % 1 == 0) {
      return result.toInt().toString();
    } else {
      return result.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            alignment: Alignment.bottomRight,
            child: Text(
              displayText,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(
                fontSize: 64,
                color: Colors.white,
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
                          text: '/',
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
                          text: '*',
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
