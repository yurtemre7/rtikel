import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/classes/german_word.dart';
import 'package:rtikel/providers/word_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ArticleButtons extends ConsumerWidget {
  const ArticleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordNotifier = ref.read(wordProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['der', 'die', 'das'].map((article) {
        return ShadButton(
          onPressed: () {
            _showFeedback(
              context,
              article == ref.read(wordProvider).article,
              ref.read(wordProvider),
            );
            wordNotifier.checkAnswer(article);
          },
          size: ShadButtonSize.lg,
          child: Text(article),
        );
      }).toList(),
    );
  }

  void _showFeedback(BuildContext context, bool isCorrect, GermanWord word) async {
    if (isCorrect) return;

    await showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        actionsMainAxisSize: MainAxisSize.min,
        title: Text(isCorrect ? 'korrekt!' : 'inkorrekt'),
        description: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    word.article,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    ' ${word.word}',
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          ShadButton(
            child: const Text('weiter'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        expandActionsWhenTiny: false,
      ),
    );
  }
}
