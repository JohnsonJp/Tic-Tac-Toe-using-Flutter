import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool oTurn = true;
  List<String> xoelements = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  void _tapped(int index) {
    setState(() {
      if (oTurn && xoelements[index] == '') {
        xoelements[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && xoelements[index] == '') {
        xoelements[index] = 'X';
        filledBoxes++;
      }
      });
  }

  Widget _portraitMode(){
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      new Scaffold(
        backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width/1.5,
          child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _tapped(index);
            },
            child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
              xoelements[index],
              style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            ),
          );
          }), 
        ),
      ),
    ),
    ],
  );
}

Widget _landscapeMode(){
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      new Scaffold(
        backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width/3,
          child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _tapped(index);
              if(oTurn==true){
                setState(() {
                oTurn=false;
              });
              }else{
                setState(() {
                oTurn=true;
              });
              }
            },
            child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
              xoelements[index],
              style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            ),
          );
          }), 
        ),
      ),
    ),
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        if(orientation == Orientation.portrait){
          return _portraitMode();
        }else{
          return _landscapeMode();
        }
      },
    );
  }
}