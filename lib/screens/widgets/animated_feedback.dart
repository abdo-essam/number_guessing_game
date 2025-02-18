import 'package:flutter/material.dart';

import '../../viewmodels/game_viewmodel.dart';

class AnimatedFeedback extends StatelessWidget {
  final String message;
  final FeedbackType feedbackType;

  const AnimatedFeedback({
    super.key,
    required this.message,
    required this.feedbackType,
  });

  Color get backgroundColor {
    switch (feedbackType) {
      case FeedbackType.success:
        return Colors.green.shade100;
      case FeedbackType.tooHigh:
        return Colors.orange.shade100;
      case FeedbackType.tooLow:
        return Colors.blue.shade100;
      case FeedbackType.error:
        return Colors.red.shade100;
      case FeedbackType.neutral:
        return Colors.grey.shade100;
    }
  }

  Color get borderColor {
    switch (feedbackType) {
      case FeedbackType.success:
        return Colors.green;
      case FeedbackType.tooHigh:
        return Colors.orange;
      case FeedbackType.tooLow:
        return Colors.blue;
      case FeedbackType.error:
        return Colors.red;
      case FeedbackType.neutral:
        return Colors.grey;
    }
  }

  Color get textColor {
    switch (feedbackType) {
      case FeedbackType.success:
        return Colors.green.shade800;
      case FeedbackType.tooHigh:
        return Colors.orange.shade800;
      case FeedbackType.tooLow:
        return Colors.blue.shade800;
      case FeedbackType.error:
        return Colors.red.shade800;
      case FeedbackType.neutral:
        return Colors.grey.shade800;
    }
  }

  IconData get feedbackIcon {
    switch (feedbackType) {
      case FeedbackType.success:
        return Icons.celebration;
      case FeedbackType.tooHigh:
        return Icons.arrow_downward;
      case FeedbackType.tooLow:
        return Icons.arrow_upward;
      case FeedbackType.error:
        return Icons.error_outline;
      case FeedbackType.neutral:
        return Icons.sports_esports;
    }
  }

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
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  feedbackIcon,
                  color: textColor,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}