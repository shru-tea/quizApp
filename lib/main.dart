import 'package:flutter/material.dart';
import 'quiz_brain.dart';
//importing rflutter alert package
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        //body: QuizPage(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int rightPerc = 0;
  int wrongPerc = 0;
  String percentage = '';
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        percentage = (rightPerc * 100 / quizBrain.totalNumberOfQuestions())
                .toStringAsFixed(2) +
            '%';
        Alert(
                context: context,
                title: "Finished",
                desc: "You have reached the end of the quiz.\n"
                    "Your total score is $percentage")
            .show();
        quizBrain.reset();
        scoreKeeper.clear();
        rightPerc = 0;
        wrongPerc = 0;
        percentage = '';
      } else {
        if (userPickedAnswer == correctAnswer) {
          rightPerc++;
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          wrongPerc++;
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(true);
              },
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(false);
              },
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),
        //keeping the Icons in a list which can be updated.
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

//  List<String> questions = [
//    'You can lead a cow down the stairs but not up the stairs.',
//    'Approximately one quarter of human bones are in the feet.',
//   'A slug\'s blood is green.',
// ];

//  List<bool> answers = [false, true, true];

//making an object of Question class
//  Question q1 = Question(
//      q: 'You can lead a cow down the stairs but not up the stairs.', a: false);
