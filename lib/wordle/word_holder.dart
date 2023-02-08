import 'dart:math';

import 'package:flutter/material.dart';



class WordHolder extends StatefulWidget {
  final String givenLetter;
  final String letterStatus;


  const WordHolder({
    Key? key,
    required this.givenLetter,
    required this.letterStatus,

  }) : super(key: key);

  @override
  State<WordHolder> createState() => _WordHolderState();
}

Color getcolor(String status) {
  if (status == 'contain') {
    return const Color(0xffb59f3b);
  } else if (status == 'correct') {
    return const Color(0xff538d4e);
  } else if (status == 'not-contain') {
    return const Color(0xff3a3a3c);
  } else {
    return Colors.black;
  }
}

class _WordHolderState extends State<WordHolder>
    {




  @override
  Widget build(BuildContext context) => wordHolderCard();

  Widget wordHolderCard() {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: getcolor(widget.letterStatus),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Color(0xff3a3a3c),
            width: 2,
          )),
      child: Center(
        child: Text(
          widget.givenLetter,
          style:
              TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold, fontFamily: 'Arimo'),
        ),
      ),
    );
  }
}
