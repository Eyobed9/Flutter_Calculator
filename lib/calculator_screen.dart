// stful - To create a stateful widget

import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String num1 = ""; // . 0-9
  String operand = ""; // + - / % *
  String num2 = ""; // . 0-9

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // screen size of the device
    final usableWidth = screenSize.width - 4;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Display bar
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$num1$operand$num2".isEmpty ? "0" : "$num1$operand$num2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // Calculator buttons
            Padding(
              padding: EdgeInsets.all(2),
              child: Wrap(
                children: CalcButtons.allButtons
                    .map(
                      (value) => SizedBox(
                        width: value == CalcButtons.zero
                            ? usableWidth / 2
                            : usableWidth / 4,
                        height: usableWidth / 5,
                        child: buildButtons(value),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function that creates the buttons
  Widget buildButtons(value) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Material(
        color: getButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        child: InkWell(
          onTap: () => onButtonTab(value),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  // Function that assign correct color to buttons based on value
  Color getButtonColor(value) {
    return [CalcButtons.del, CalcButtons.clr].contains(value)
        ? Colors.blueGrey
        : [
            CalcButtons.per,
            CalcButtons.multiply,
            CalcButtons.divide,
            CalcButtons.subtract,
            CalcButtons.add,
          ].contains(value)
        ? Colors.orange
        : Colors.black87;
  }

  // Function that determines action based on clicked value
  void onButtonTab(String value) {
    // If delete is pressed
    if (value == CalcButtons.del) {
      delete();
      return;
    }

    // If clear is pressed
    if (value == CalcButtons.clr) {
      clear();
      return;
    }

    // If percent is pressed
    if (value == CalcButtons.per) {
      calculatePercentage();
      return;
    }

    // If equal to is pressed 
    if (value == CalcButtons.equals) {
      
    }

    appendValue(value);
    setState(() {});
  }

  // Append value to the display
  void appendValue(String value) {
    // If it is an operand
    if (value != CalcButtons.dot && int.tryParse(value) == null) {
      // Calculate the result
      if (num2.isNotEmpty && operand.isNotEmpty) {}

      // Append the operand
      if (num1.isNotEmpty && operand.isEmpty) {
        if (num1.substring(num1.length - 1) == CalcButtons.dot) {
          num1 = num1.substring(0, num1.length - 1);
        }
        operand = value;
      }
    }
    // Assign the value of num1
    else if (num2.isEmpty && operand.isEmpty) {
      // If the value is dot
      if (value == CalcButtons.dot && !num1.contains(CalcButtons.dot)) {
        if (num1.isEmpty) {
          num1 = "0.";
        } else {
          num1 += value;
        }
      } else if (value != CalcButtons.dot) {
        num1 += value;
      }
    }
    // Assign the value of num2
    else if (num1.isNotEmpty && operand.isNotEmpty) {
      // If the value is dot
      if (value == CalcButtons.dot && !num2.contains(CalcButtons.dot)) {
        if (num2.isEmpty) {
          num2 = "0.";
        } else {
          num2 += value;
        }
      } else if (value != CalcButtons.dot) {
        num2 += value;
      }
    }
  }

  // Delete value from the display
  void delete() {
    if (num2.isNotEmpty) {
      num2 = num2.substring(0, num2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (num1.isNotEmpty) {
      num1 = num1.substring(0, num1.length - 1);
    }
  }

  // Clear the display
  void clear() {
    num1 = "";
    operand = "";
    num2 = "";
  }

  // Calculate the percentage 
  void calculatePercentage() {
    // For full expression
    if (num1.isNotEmpty && num2.isNotEmpty && operand.isNotEmpty) {
      // Calculate the result 
    }

    if (operand.isNotEmpty) {
      return;
    }

    final num = double.parse(num1);
    setState(() {
       num1 = "${(num / 100)}";
       operand = "";
       num2 = "";
    });
  
  }
}
