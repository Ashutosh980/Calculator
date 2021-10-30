import 'package:calculator/widgets/CalcButton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
debugShowCheckedModeBanner: false,
home: HomeApp(),
));
}
class HomeApp extends StatefulWidget {
  const HomeApp({ Key? key}) : super(key: key);
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String _history = '';
  String _expression = '';

void backPrs(String text){
  setState(() =>_expression=_expression.substring(0,_expression.length-1));
}

  void numClick(String text) {
    setState(() => _expression += text);
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();

    setState(() {
      _history = _expression;
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal:8.0,vertical: 35.0),
                    child: Text(_history, style: TextStyle(
                        fontSize: 50.0
                    ),)
                ),
                Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal:8.0,vertical: 35.0),
                    child: Text(_expression, style: TextStyle(
                        fontSize: 50.0
                    ),)
                ),

                Expanded(child: Divider(),),
                Row(
                  children: <Widget>[
                    CalcButton(text: 'X', callback: allClear),
                    CalcButton(text: 'C', callback: clear),
                    CalcButton(text: '<', callback: backPrs),
                    CalcButton(text: '/', callback: numClick),
                    /* Row(
                    )*/
                  ],
                ),
                Row(

                  children: <Widget>[
                    CalcButton(
                      text: '7',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '8',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '9',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '*',
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    CalcButton(
                      text: '4',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '5',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '6',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '-',
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    CalcButton(
                      text: '1',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '2',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '3',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '+',
                      callback: numClick,
                    ),
                  ],
                ),
                Row(

                  children: <Widget>[
                    CalcButton(
                      text: '.',
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '0',
                      callback: numClick,
                    ),

                    CalcButton(
                      text: '=',

                      callback: evaluate,
                    ),
                  ],
                )

              ],
            ),
          )
      ),
    );
  }
}