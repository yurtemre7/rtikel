import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/classes/german_word.dart';
import 'package:rtikel/providers/b1word_provider.dart' as B1WP;
import 'package:rtikel/providers/index_provider.dart';
import 'package:rtikel/providers/progress_provider.dart';
import 'package:rtikel/providers/word_provider.dart' as WP;
import 'package:rtikel/view/components/article_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(WP.wordProvider);
    final wordNotifier = ref.read(WP.wordProvider.notifier);
    final b1Word = ref.watch(B1WP.b1wordProvider);
    final b1WordNotifier = ref.read(B1WP.b1wordProvider.notifier);

    final index = ref.watch(indexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('rtikel $index'),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            ref.read(indexProvider.notifier).state = value;
          },
          children: [
            buildWords(wordNotifier, ref, word),
            buildB1Words(b1WordNotifier, ref, b1Word),
          ],
        ),
      ),
      floatingActionButton: const SafeArea(
        child: ArticleButtons(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildWords(WP.WordNotifier wordNotifier, WidgetRef ref, GermanWord word) {
    return Column(
      children: [
        if (wordNotifier.getWords().isNotEmpty)
          LinearProgressIndicator(
            value: (ref.read(progressProvider).correct + ref.read(progressProvider).incorrect) /
                wordNotifier.getWords().length,
          ),
        const SizedBox(
          height: 8,
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
    );
  }

  Widget buildB1Words(B1WP.WordNotifier wordNotifier, WidgetRef ref, GermanWord word) {
    return Column(
      children: [
        if (wordNotifier.getWords().isNotEmpty)
          LinearProgressIndicator(
            value: (ref.read(progressProvider).correct + ref.read(progressProvider).incorrect) /
                wordNotifier.getWords().length,
          ),
        const SizedBox(
          height: 8,
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
    );
  }
}
