import 'package:flutter/material.dart';

class QuizController with ChangeNotifier {
  final List<int?> _answers = [];

  QuizController(int numberOfQuestions) {
    _answers.length = numberOfQuestions;
  }

  int? getAnswer(int index) => _answers[index];

  void setAnswer(int index, int answer) {
    _answers[index] = answer;
    notifyListeners();
  }

  int get yesCount => _answers.where((answer) => answer == 0).length;
  int get noCount => _answers.where((answer) => answer == 1).length;
  int get numberOfQuestions => _answers.length;
}
