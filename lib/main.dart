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
  int boxes = 0;

  void _tapped(int index) {
    setState(() {
      if (oTurn && xoelements[index] == '') {
        xoelements[index] = 'O';
        boxes++;
      } else if (!oTurn && xoelements[index] == '') {
        xoelements[index] = 'X';
        boxes++;
      }
      
      oTurn = !oTurn;
      _checkWinner();
    });

  }

  void _checkWinner() {

    // Checking rows
    if (xoelements[0] == xoelements[1] &&
      xoelements[0] == xoelements[2] &&
      xoelements[0] != '') {
    _showWinDialog(xoelements[0]);
    }else if (xoelements[3] == xoelements[4] &&
      xoelements[3] == xoelements[5] &&
      xoelements[3] != '') {
    _showWinDialog(xoelements[3]);
    }else if (xoelements[6] == xoelements[7] &&
      xoelements[6] == xoelements[8] &&
      xoelements[6] != '') {
    _showWinDialog(xoelements[6]);
    }else if(xoelements[0] == xoelements[3] &&
      xoelements[0] == xoelements[6] &&
      xoelements[0] != '') {
    _showWinDialog(xoelements[0]);
    }else if (xoelements[1] == xoelements[4] &&
      xoelements[1] == xoelements[7] &&
      xoelements[1] != '') {
    _showWinDialog(xoelements[1]);
    }else if (xoelements[2] == xoelements[5] &&
      xoelements[2] == xoelements[8] &&
      xoelements[2] != '') {
    _showWinDialog(xoelements[2]);
    }else if (xoelements[0] == xoelements[4] &&
      xoelements[0] == xoelements[8] &&
      xoelements[0] != '') {
    _showWinDialog(xoelements[0]);
    }else if (xoelements[2] == xoelements[4] &&
      xoelements[2] == xoelements[6] &&
      xoelements[2] != '') {
    _showWinDialog(xoelements[2]);
    } else if (boxes == 9) {
    _showDrawDialog();
  }
 }

void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        title: Text("\" " + winner + " \" is Winner!!!"),
        actions: [
        MaterialButton(
          child: Text("Play Again"),
          onPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
          },
        )
        ],
      );
      });
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Draw"),
        actions: [
        MaterialButton(
          child: Text("Play Again"),
          onPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
          },
        )
        ],
      );
      });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
      xoelements[i] = '';
      }
    });
    oTurn = true;
    boxes = 0;
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