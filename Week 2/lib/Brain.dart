import 'Question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Answer to this question is True', false),
    Question('Answer to previous question is False', false),
    Question('Mount Everest is the Tallest Mountain', true),
    Question('IIT-B is the Best Institute in the World', true),
    Question('Humans have two eyes', true),
    Question('First living being in space was a Human', false),
    Question('Modi is the best Prime Minister in the world', false),
    Question('BTS is the most popular band in the World', true),
    Question('Water is the most wet thing', false),
    Question('Taj Mahal was built with love', false),
    Question('You are happy that you are stuck in home in pandemic', true),
    Question(
        'Vatican city is the country with most number of COVID cases', false),
    Question('Iron Man is the Strongest Super Hero', true),
    Question('There exists 26 alphabets in total', false),
  ];

  void getNextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionBank[_questionNumber].question;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].answer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1)
      return true;
    else
      return false;
  }

  void reset() {
    _questionNumber = 0;
  }
}
