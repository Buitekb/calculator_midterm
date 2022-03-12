import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(64, 64, 64, 1)),
      title: 'Flutter Demo',
      home: CalcPage(),
    );
  }
}

class CalcPage extends StatefulWidget {
  const CalcPage({Key? key}) : super(key: key);

  @override
  _CalcPageState createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  static double evaluateExpression(String expression) {
    List<String> stringOperands =
        expression.split(RegExp(r"[\-\+\X\/]")); //10-10
    List<String> operators =
        expression.splitMapJoin(RegExp(r"[\-\+\/\X]"), onMatch: (m) {
      return m[0]!;
    }, onNonMatch: (n) {
      return "";
    }).split("");
    //25 - 25 +60
    List<double> operands = stringOperands.map((e) {
      return double.parse(e);
    }).toList();

    debugPrint(operands.toString());
    debugPrint(operators.toString());

    return _delegateEvaluation(operands, operators);
  }

  static double _delegateEvaluation(
      List<double> operands, List<String> operators) {
    debugPrint(operands.toString());
    debugPrint(operators.toString());

    if (operands.length == 1) {
      return operands[0];
    }

    if (operators.contains("X") || operators.contains("/")) {
      int multi = operators.indexOf("X");
      int divide = operators.indexOf("/");

      if ((multi < divide || divide == -1) && multi != -1) {
        double result = operands[multi] * operands[multi + 1];
        operands.removeAt(multi + 1);
        operands.removeAt(multi);
        operands.insert(multi, result);
        operators.removeAt(multi);

        return _delegateEvaluation(operands, operators);
      } else if (divide != -1) {
        double result = (operands[divide] / operands[divide + 1]);
        operands.removeAt(divide + 1);
        operands.removeAt(divide);
        operands.insert(divide, result);
        operators.removeAt(divide);
        return _delegateEvaluation(operands, operators);
      }
    }

    if (operators[0] == "+") {
      int plus = 0;

      double result = operands[plus] + operands[plus + 1];
      operands.removeAt(plus + 1);
      operands.removeAt(plus);
      operands.insert(plus, result);
      operators.removeAt(plus);
      return _delegateEvaluation(operands, operators);
    }

    if (operators[0] == "-") {
      int minus = 0;
      double result = operands[minus] - operands[minus + 1];
      operands.removeAt(minus + 1);
      operands.removeAt(minus);
      operands.insert(minus, result);
      operators.removeAt(minus);
      return _delegateEvaluation(operands, operators);
    }

    return 0;
  }

  var text = '';
  var output = 0;

  Widget CalcButton(String textButton, int buttonValue, Color color) {
    return Expanded(
      child: Container(
          color: Color.fromRGBO(64, 64, 64, 1),
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(33), primary: color),
              onPressed: () {
                setState(() {
                  if (textButton == '=') {
                    text = evaluateExpression(text).toString();
                  } else if (textButton == 'C') {
                    text = '';
                  } else {
                    text += textButton;
                  }
                });
              },
              child: Text(
                textButton,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calc Midterm"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  )
                ],
              ),
              Row(
                children: [
                  CalcButton("C", 0, Color.fromRGBO(92, 93, 93, 1)),
                  CalcButton("-/+", 1, Color.fromRGBO(92, 93, 93, 1)),
                  CalcButton("%", 11, Color.fromRGBO(92, 93, 93, 1)),
                  CalcButton("/", 12, Color.fromRGBO(242, 162, 61, 1)),
                ],
              ),
              Row(
                children: [
                  CalcButton("7", 7, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("8", 8, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("9", 9, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("X", 13, Color.fromRGBO(242, 162, 61, 1)),
                ],
              ),
              Row(
                children: [
                  CalcButton("4", 4, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("5", 5, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("6", 6, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("-", 14, Color.fromRGBO(242, 162, 61, 1)),
                ],
              ),
              Row(
                children: [
                  CalcButton("1", 2, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("2", 3, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("3", 4, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("+", 15, Color.fromRGBO(242, 162, 61, 1)),
                ],
              ),
              Row(
                children: [
                  CalcButton("0", 0, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton(".", 1, Color.fromRGBO(121, 121, 122, 1)),
                  CalcButton("=", 16, Color.fromRGBO(242, 162, 61, 1)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
