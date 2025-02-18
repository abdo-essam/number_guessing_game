import 'dart:math';
import 'package:flutter/foundation.dart';

class GameViewModel extends ChangeNotifier {
  final int _maxNumber = 100;
  late int _targetNumber;
  int _attempts = 0;
  String _feedback = '';
  bool _gameWon = false;

  int get attempts => _attempts;
  String get feedback => _feedback;
  bool get gameWon => _gameWon;

  GameViewModel() {
    startNewGame();
  }

  void startNewGame() {
    _targetNumber = Random().nextInt(_maxNumber) + 1;
    _attempts = 0;
    _feedback = 'Guess a number between 1 and $_maxNumber';
    _gameWon = false;
    notifyListeners();
  }

  void checkGuess(String guess) {
    if (_gameWon) return;

    int? number = int.tryParse(guess);
    if (number == null) {
      _feedback = 'Please enter a valid number';
      notifyListeners();
      return;
    }

    _attempts++;

    if (number == _targetNumber) {
      _gameWon = true;
      _feedback = 'Congratulations! You got it in $_attempts attempts!';
    } else if (number < _targetNumber) {
      _feedback = 'Try higher!';
    } else {
      _feedback = 'Try lower!';
    }

    notifyListeners();
  }
}