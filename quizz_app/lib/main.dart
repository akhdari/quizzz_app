import 'package:flutter/material.dart';
import 'listOfQstns.dart';
import 'addElement.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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

  double score = 0;
  int listIndex = 0;
  Listofqstns qstnsListInstance = Listofqstns();
  List<Icon> scoreKeeper = [];

  void resetQuiz(int index) {
    qstnsListInstance.reSetIdex(index);
    scoreKeeper.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //column1
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: Column(
              children: [
                LinearPercentage(
                  currentPercentage: score,
                  maxPercentage: 100,
                  backgroundHeight: 20,
                  percentageHeight: 20,
                  leftRightText: LeftRightText.both,
                  showPercentageOnPercentageView: true,
                  percentageOnPercentageViewTextStyle:
                      const TextStyle(color: Colors.white),
                  backgroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38,
                  ),
                  percentageDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
                Text(
                  //accessing the lsit property of the qstnsList instance
                  'question${1 + listIndex}:${qstnsListInstance.getQuestionText(listIndex)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
          ),
        ),

        //column2

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool user_choice = true;
                bool isTrue = (user_choice ==
                    qstnsListInstance.getQuestionValue(listIndex));
                if (qstnsListInstance.moreElements(listIndex)) {
                  setState(() {
                    scoreKeeper.add(AddElement().addElement(isTrue));
                    //only update when matches the value of the qstn (correct)
                    score = qstnsListInstance.addToScore(
                    score, user_choice, listIndex);
                  });
                  listIndex++;

                } else {
                  //reached the last qstn in the list of qstns
                  setState(() {
                    score = qstnsListInstance.addToScore(
                    score, user_choice, listIndex);
                    scoreKeeper.add(AddElement().addElement(isTrue));
                    Alert(
                      context: context,
                      title: "Alert",
                      desc: "end of quiz",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Repeat",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          //TODO:reSetQuiz()
                          onPressed: () {
                            setState(() {
                              scoreKeeper.clear();
                              score=0;
                              listIndex=0;
                            });
                            Navigator.of(context).pop();
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  });
                }
              },
            ),
          ),
        ),

        //column3

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                bool user_choice = false;
                bool isTrue = (user_choice ==
                    qstnsListInstance.getQuestionValue(listIndex));
                if (qstnsListInstance.moreElements(listIndex)) {
                  setState(() {
                    scoreKeeper.add(AddElement().addElement(isTrue));

                    score = qstnsListInstance.addToScore(
                    score, user_choice, listIndex);
                  });
                  listIndex++;

                } else {
                  setState(() {
                    scoreKeeper.add(AddElement().addElement(isTrue));
                    score = qstnsListInstance.addToScore(
                    score, user_choice, listIndex);
                    Alert(
                      context: context,
                      title: "Alert",
                      desc: "end of quiz",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Repeat",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              scoreKeeper.clear();
                              score=0;
                              listIndex=0;
                            });
                            Navigator.of(context).pop();
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  });
                }
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
