import 'package:flutter/material.dart';
import 'package:wordle_clone/wordle/input_button.dart';



class InputKeyboard extends StatelessWidget {
  final Function toWord;
  final Function delChar;
  final Function enterTheWord;


  InputKeyboard(
      {required this.toWord,
      required this.delChar,
      required this.enterTheWord,
      });

  @override
  Widget build(BuildContext context) {
    List<String> firstRow = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    List<String> secondRow = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    List<String> thirdRow = ['Z', 'X', 'C', 'V', 'B', 'N', 'M'];
//aasadsadasdsad
    return Container(


      child: Column(

        children: [


          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: firstRow.map((letter) {
                  return Expanded(
                    child: Container(

                      margin: EdgeInsets.all(2),

                      child: InputButton(letter: letter, letterPressed: toWord,),

                    ),
                  );
                }).toList()),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: secondRow.map((letter) {
                  return Expanded(
                    child: Container(
                        margin: EdgeInsets.all(2),
                        child: InputButton(letter: letter, letterPressed: toWord,),
                       ),
                  );
                }).toList()),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  margin: EdgeInsets.all(2),
                  child: ElevatedButton(
                    child: Text('Enter'),
                    onPressed: () => enterTheWord(),
                    style: ElevatedButton.styleFrom(primary: Color(0xff818384)),
                  ),
                ),
                ...thirdRow.map((letter) {
                  return Expanded(
                    child: Container(
                        margin: EdgeInsets.all(2),
                        child: InputButton(
                          letter: letter,
                          letterPressed: toWord,

                        ),
                        ),
                  );
                }).toList(),
                Container(
                  margin: EdgeInsets.all(2),
                  child: InputButton(letter: 'Del', letterPressed: delChar,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
