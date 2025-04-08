import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userinput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 87, 87),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // WHOLE WHITE BOX DISPLAY (user input + result)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        userinput,
                        style: TextStyle(fontSize: 28, color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: Colors.white),

              // BUTTON GRID SECTION
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: buttonList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomButton(buttonList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // CUSTOM BUTTON WIDGET
  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.black,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // BUTTON TEXT COLOR
  getColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == 'C' ||
        text == '(' ||
        text == ')') {
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  // BUTTON BACKGROUND COLOR
  getBgColor(String text) {
    if (text == 'AC') {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return Color.fromARGB(255, 8, 243, 129);
    }
    return Colors.black;
  }

  // HANDLE BUTTON TAPS
  void handleButtons(String text) {
    if (text == "AC") {
      userinput = "";
      result = "0";
    } else if (text == "C") {
      if (userinput.isNotEmpty) {
        userinput = userinput.substring(0, userinput.length - 1);
      }
    } else if (text == "=") {
      result = calculate();
      userinput = result;

      if (userinput.endsWith(".0")) {
        userinput = userinput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
    } else {
      userinput += text;
    }
  }

  // MATH CALCULATION
  String calculate() {
    try {
      var exp = Parser().parse(userinput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
