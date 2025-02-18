import 'package:flutter/material.dart';

class AnimatedFeedback extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const AnimatedFeedback({
    super.key,
    required this.message,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: isSuccess ? Colors.green.shade100 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSuccess ? Colors.green : Colors.blue,
                width: 2,
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isSuccess ? Colors.green.shade800 : Colors.blue.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}