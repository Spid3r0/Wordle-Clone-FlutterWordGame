import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/wordle/word_holder.dart';
import 'package:wordle_clone/wordle/result.dart';


import 'input_keyboard.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

String pressedText = '';
String hiddenWord = '';

Random random = new Random();
int randomNumber = random.nextInt(100);

//List<FlipCardController> controllerList =  List<FlipCardController>.filled(30, FlipCardController(), growable: false);
List<String> wordTable = List<String>.filled(30, '', growable: false);
List<String> wordStatus = List<String>.filled(30, 'non', growable: false);
int gamePlayed = 0;
int wonGame =0;

int tableIndexCounter = 0;
int rowIndexCounter = 0;
int rowIndexCoefficient = 5;
String guessedWord = '';
bool animationStarted = false;
double animationDuration = 0.0;
bool gameIsOver = false;

//final ValueNotifier<List<String>> _counter = ValueNotifier(wordTable);

class FlipCardController {
  _ScreenState? _state;

  Future flipCard() async => _state?.flipCard();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  final controllerTemp = FlipCardController();

  late AnimationController controller;

  Future flipCard() async {
    if (!animationStarted) {
      if (controller.isAnimating) return;

      controller.forward();
      animationStarted = !animationStarted;
    } else {
      controller.reverse();
      animationStarted = !animationStarted;
    }
  }

  Future<List<String>> _loadQuestions() async {
    List<String> questions = [];
    await rootBundle.loadString('assets/word.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        questions.add(i);
      }
    });
    return questions;
  }

  List<String> wordList = [];

  _setup() async {
    List<String> words = await _loadQuestions();

    setState(() {
      wordList = words;

      hiddenWord = wordList[randomNumber].toUpperCase();
      print(hiddenWord);
      random = new Random();
      randomNumber = random.nextInt(100);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
    controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    controllerTemp._state = this;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool animationActiveRow(int index) {
    if (index <= 4 + ((rowIndexCounter - 1) * rowIndexCoefficient) &&
        index >= ((rowIndexCounter - 1) * rowIndexCoefficient)) {
      return true;
    } else {

      return false;
    }
  }

  void resetGame(){

  setState(() {

    wordTable = List<String>.filled(30, '', growable: false);
    wordStatus = List<String>.filled(30, 'non', growable: false);
    tableIndexCounter = 0;
    rowIndexCounter = 0;
    rowIndexCoefficient = 5;
    guessedWord = '';
    animationStarted = false;
    animationDuration = 0.0;
    gameIsOver = false;
    _setup();



  });
  }

  void enterWord() {
    setState(() {
      if ((wordTable[(rowIndexCounter * rowIndexCoefficient) + 4] != '')) {
        //if 5 letter didn't not entered do nothing

        int tableIndex =
            tableIndexCounter + (rowIndexCounter * rowIndexCoefficient);
        List<String> tempWord = wordTable.sublist(
            (tableIndex - 4), tableIndex + 1); //getting only on word row
        guessedWord = tempWord.join();
        if (wordList.contains(guessedWord.toLowerCase())) {
          print(guessedWord);

          ControlWord(tempWord, rowIndexCounter);
          rowIndexCounter++;
          tableIndexCounter = 0;
          controllerTemp.flipCard();

          if (guessedWord == hiddenWord) {
            gameIsOver = true;
            gamePlayed ++;
            wonGame++;
            _showMyDialog(context ,'Won');
          }
          if(tableIndex == 29 && guessedWord != hiddenWord ){
            gameIsOver = true;
            gamePlayed++;
            _showMyDialog(context ,'Lose');
          }

        } else {
          print('NOT IN WORD LIST');
          _showWordError(context);
        }
      }
    });
  }

  void ControlWord(List<String> word, int rowIndex) {
    List<String> result = hiddenWord.split('');

    for (int i = 0; i < result.length; i++) {
      if (result.contains(word[i])) {
        wordStatus[(rowIndex * 5) + i] = 'contain';
        if (word[i] == result[i]) {
          wordStatus[(rowIndex * 5) + i] = 'correct';
        }
      } else {
        wordStatus[(rowIndex * 5) + i] = 'not-contain';
      }
    }


  }

  void delLetter(String letter) {
    int tableIndex =
        tableIndexCounter + (rowIndexCounter * rowIndexCoefficient);
    setState(() {
      if (wordTable[tableIndex] == '') {
        if (tableIndex != 0) {
          if (tableIndex - 1 !=
              (4 + (rowIndexCoefficient * (rowIndexCounter - 1)))) {
            wordTable[tableIndex - 1] = '';
          }
        }
      } else {
        wordTable[tableIndex] = '';
      }
      if (tableIndexCounter > 0) {
        tableIndexCounter--;
      }


    });
  }

  void letterToWord(String letter) {
    int tableIndex =
        tableIndexCounter + (rowIndexCounter * rowIndexCoefficient);

    if (gameIsOver == false) {
      setState(() {
        if (tableIndexCounter <= 4) {
          wordTable[tableIndex] = letter;

        } else {}
        tableIndexCounter++;

        if (tableIndexCounter > 4) {
          tableIndexCounter = 4;
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Wordle Game', debugShowCheckedModeBanner:  false,

      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.black12,
      ),

      home: Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
          onTap: () => {Navigator.pop(context,'wordle'), },
        ),
        title:  Text('WORDLE'),
        shadowColor: Colors.grey,
        backgroundColor: Color(0xff121213),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.bar_chart,
              size: 30,
              color: Colors.white,
            ),
            onTap: () => {_showMyDialog(context,'')},
          ),
        ],
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [

            // Center(child: ResultScreen(gameIsOver: gameIsOver,)),
            Container(
              margin: const EdgeInsets.all(10),
              height: 360,
              width: 300,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: wordTable.length,
                  itemBuilder: (BuildContext context, int index) =>
                  animationActiveRow(index) == true
                      ? Container(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      transitionBuilder: _transitionBuilder,
                      switchInCurve: Curves.easeInBack,
                      switchOutCurve: Curves.easeInBack.flipped,
                      child: WordHolder(
                        letterStatus: wordStatus[index],
                        givenLetter: wordTable[index],
                      ),
                    ),
                  )
                      : Container(
                      child: WordHolder(
                        letterStatus: wordStatus[index],
                        givenLetter: wordTable[index],
                      ))),
            ),

            InputKeyboard(
              toWord: letterToWord,
              delChar: delLetter,
              enterTheWord: enterWord,
            ),
          ],
        ),
      ),
    )



    );
  }

  Future<void> _showMyDialog(BuildContext context,String str) async {
    return Future.delayed(Duration(seconds: 1), () {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Container(
            child: Result(
              word: hiddenWord,
              reset: resetGame,
              resultGame: str,
              won: wonGame,
              played: gamePlayed,
            ),
          );
        },
      );
    });
  }

  Future<void> _showWordError(BuildContext context) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      showDialog<void>(
        context: context,
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: true,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return SimpleDialog(
            alignment: Alignment.topCenter,
            insetPadding: EdgeInsets.symmetric(vertical: 100),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            children: [
              Container(
                child: Center(
                  child: Text(
                    'Not in word list',
                    style: TextStyle(fontFamily: 'Arimo', fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animaiton) {
    return AnimatedBuilder(
        builder: (context, child) {
          final angle = controller.value * 2 * -pi;
          final transform = Matrix4.rotationX(angle);

          return Transform(
              transform: transform, alignment: Alignment.center, child: widget);
        },
        animation: controller);
  }
}
