import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/classes/german_word.dart';
import 'package:rtikel/providers/b1word_provider.dart';
import 'package:rtikel/providers/index_provider.dart';
import 'package:rtikel/providers/word_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ArticleButtons extends ConsumerWidget {
  const ArticleButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordNotifier = ref.read(wordProvider.notifier);
    final b1wordNotifier = ref.read(b1wordProvider.notifier);
    final index = ref.watch(indexProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['der', 'die', 'das'].map((article) {
        return ShadButton(
          onPressed: () {
            switch (index) {
              case 0:
                _showFeedback(
                  context,
                  article == ref.read(wordProvider).article,
                  ref.read(wordProvider),
                );
                wordNotifier.checkAnswer(article);
              case 1:
                _showFeedback(
                  context,
                  article == ref.read(b1wordProvider).article,
                  ref.read(b1wordProvider),
                );
                b1wordNotifier.checkAnswer(article);
            }
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
      variant: ShadDialogVariant.alert,
      builder: (context) => ShadDialog.alert(
        radius: BorderRadius.circular(12),
        removeBorderRadiusWhenTiny: false,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
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
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    ' ${word.word}',
                    style: const TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        expandActionsWhenTiny: false,
      ),
    );
  }
}
