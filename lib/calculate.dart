import 'dart:io';

void main() {
  print("Enter first number:");
  double num1 = double.parse(stdin.readLineSync()!);

  print("Enter second number:");
  double num2 = double.parse(stdin.readLineSync()!);

  print("Enter operator (+, -, *, /):");
  String operator = stdin.readLineSync()!;

  double result;

  if (operator == '+') {
    result = num1 + num2;
  } else if (operator == '-') {
    result = num1 - num2;
  } else if (operator == '*') {
    result = num1 * num2;
  } else if (operator == '/') {
    if (num2 == 0) {
      print("Cannot divide by zero.");
      return;
    }
    result = num1 / num2;
  } else {
    print("Invalid operator.");
    return;
  }

  print("Result: $result");
}
