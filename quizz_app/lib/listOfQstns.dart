import 'question.dart';



class Listofqstns {
  //list property
  List<Question> _qstnsList = [
    Question(
        qstnText: 'You can lead a cow down stairs but not up stairs.',
        qstnValue: false),
    Question(
        qstnText: 'Approximately one quarter of human bones are in the feet.',
        qstnValue: false),
    Question(qstnText: 'A slug\'s blood is green.', qstnValue: true),
  ];



  int listLength(){
    return _qstnsList.length;
    //Why -1? bcs within main the else statement handle the last element and not if 
  }
  String getQuestionText(int a){
    return _qstnsList[a].qstnText;
  }
  bool getQuestionValue(int a){
    return _qstnsList[a].qstnValue;
  }

  bool moreElements( int index){
    //we should generate a return for if statements in both conditions weather if the conditin is met or not
    if (index<listLength()-1){
      //index.compareTo(_qstnsList.lastIndexOf(_qstnsList.last)) < 0
      print(true);
      return true;
    }
    else{
      print('last element');
      return false;
    }
  }
int reSetIdex(int index){
      return 0;
    }

  bool isCorrect(bool user_choice, int a){
    return (user_choice == getQuestionValue(a));
  }

  double addToScore(double score, bool user_choice, int listIndex){
    if(user_choice == getQuestionValue(listIndex)){
      return score+(100/listLength());
    }
    else{return score;}
  }

}