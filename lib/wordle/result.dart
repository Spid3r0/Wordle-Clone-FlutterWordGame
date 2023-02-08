import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final String word;
  final Function reset;
  final String resultGame;
  final int played;
  final int won;

  const Result({
    Key? key,
    required this.word,
    required this.reset,
    required this.resultGame,
    required this.played,
    required this.won,
  }) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.grey)),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white,
      title: const Text(''),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: 300,
              height: 500,
              child: Column(
                children: [
                  Text(
                    'STATISTICS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.played.toString(),
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 30),
                      ),
                      Text(
                        widget.played ==0 ?
                            '0'
                            :
                        (((widget.won * 100)/widget.played )).toInt().toString(),
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 30),
                      ),
                      Text(
                        widget.won.toString(),
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Played'),
                      Text('Win%'),
                      Text('Streak'),
                    ],
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  Center(
                    child: Text(
                      widget.resultGame,
                      style: TextStyle(fontFamily: 'Arimo', fontSize: 30),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {widget.reset()},
                    child: Icon(
                      Icons.replay,
                      size: 30,
                    ),
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.grey,
                    child: Text(
                      widget.word,
                      style: TextStyle(fontFamily: 'Arimo', fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
