import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import 'widgets/animated_feedback.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: _GameContent(),
        ),
      ),
    );
  }
}

class _GameContent extends StatefulWidget {
  @override
  _GameContentState createState() => _GameContentState();
}

class _GameContentState extends State<_GameContent>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(
      builder: (context, gameVM, child) {
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 40),
                _buildGameCard(gameVM),
                const SizedBox(height: 30),
                _buildAttempts(gameVM),
                const SizedBox(height: 20),
                if (gameVM.gameWon) _buildPlayAgainButton(gameVM),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.white, Colors.blue.shade200],
      ).createShader(bounds),
      child: const Text(
        'Number Guessing Game',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGameCard(GameViewModel gameVM) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Column(
          children: [
            AnimatedFeedback(
              message: gameVM.feedback,
              isSuccess: gameVM.gameWon,
            ),
            const SizedBox(height: 25),
            CustomTextField(
              controller: _controller,
              hintText: 'Enter your guess',
              onSubmitted: () {
                _animationController.forward().then((_) {
                  gameVM.checkGuess(_controller.text);
                  _controller.clear();
                  _animationController.reverse();
                });
              },
            ),
            const SizedBox(height: 25),
            CustomButton(
              text: 'Make Guess',
              onPressed: () {
                _animationController.forward().then((_) {
                  gameVM.checkGuess(_controller.text);
                  _controller.clear();
                  _animationController.reverse();
                });
              },
              color: Colors.blue.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttempts(GameViewModel gameVM) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Text(
            'Attempts: ${gameVM.attempts}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayAgainButton(GameViewModel gameVM) {
    return CustomButton(
      text: '🎮 Play Again',
      onPressed: () {
        _animationController.forward().then((_) {
          gameVM.startNewGame();
          _animationController.reverse();
        });
      },
      color: Colors.green.shade600,
    );
  }
}