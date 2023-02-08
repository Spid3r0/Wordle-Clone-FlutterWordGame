import 'package:flutter/material.dart';

class InputButton extends StatefulWidget {
  final String letter;
  final Function letterPressed;


  InputButton({
    required this.letter,
    required this.letterPressed,

  });

  @override
  State<InputButton> createState() => _InputButtonState();
}




class _InputButtonState extends State<InputButton> {

  /*
  Color getcolor() {
    if (widget.letterStatus.contains(widget.letter)) {
      return const Color(0xff538d4e);
    } else if (!widget.letterStatus.contains(widget.letter)) {
      return const Color(0xff3a3a3c);
    }  else {
      return Color(0xff818384);
    }
  }

*/


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.letterPressed(widget.letter),
      child: Text(widget.letter),
      style: ElevatedButton.styleFrom(primary: Color(0xff818384)),
    );
  }
}
