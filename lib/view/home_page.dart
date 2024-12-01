import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/providers/progress_provider.dart';
import 'package:rtikel/providers/word_provider.dart';
import 'package:rtikel/view/components/article_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordProvider);
    final wordNotifier = ref.read(wordProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('rtikel'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (wordNotifier.getWords().isNotEmpty)
              LinearProgressIndicator(
                value: (ref.read(progressProvider).correct + ref.read(progressProvider).incorrect) /
                    wordNotifier.getWords().length,
              ),
            Text(
              '${(ref.read(progressProvider).correct + ref.read(progressProvider).incorrect)} / ${wordNotifier.getWords().length}',
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      word.word,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // if (kDebugMode) Text(word.article),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const SafeArea(
        child: ArticleButtons(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
