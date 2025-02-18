import 'dart:math';

import 'package:flutter/material.dart';

class GameViewModel extends ChangeNotifier {
  final int _maxNumber = 100;
  late int _targetNumber;
  int _attempts = 0;
  String _feedback = '';
  bool _gameWon = false;
  FeedbackType _feedbackType = FeedbackType.neutral;

  int get attempts => _attempts;

  String get feedback => _feedback;

  bool get gameWon => _gameWon;

  FeedbackType get feedbackType => _feedbackType;

  GameViewModel() {
    startNewGame();
  }

  void startNewGame() {
    _targetNumber = Random().nextInt(_maxNumber) + 1;
    _attempts = 0;
    _feedback = 'Guess a number between 1 and $_maxNumber';
    _gameWon = false;
    _feedbackType = FeedbackType.neutral;
    notifyListeners();
  }

  void checkGuess(String guess) {
    if (_gameWon) return;

    int? number = int.tryParse(guess);
    if (number == null) {
      _feedback = 'Please enter a valid number';
      _feedbackType = FeedbackType.error;
      notifyListeners();
      return;
    }

    _attempts++;

    if (number == _targetNumber) {
      _gameWon = true;
      _feedback = 'Congratulations! You got it in $_attempts attempts!';
      _feedbackType = FeedbackType.success;
    } else if (number < _targetNumber) {
      _feedback = 'Too low! Try again.';
      _feedbackType = FeedbackType.tooLow;
    } else {
      _feedback = 'Too high! Try again.';
      _feedbackType = FeedbackType.tooHigh;
    }

    notifyListeners();
  }
}

enum FeedbackType {
  neutral,
  tooHigh,
  tooLow,
  success,
  error,
}
