import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/classes/german_word.dart';
import 'package:rtikel/providers/progress_provider.dart';
import 'package:rtikel/services/word_service.dart';

final wordProvider = StateNotifierProvider<WordNotifier, GermanWord>((ref) {
  return WordNotifier(ref);
});

class WordNotifier extends StateNotifier<GermanWord> {
  final Ref ref;
  List<GermanWord> _words = [];

  WordNotifier(this.ref) : super(GermanWord(word: '', article: '')) {
    _loadWords();
  }

  Future<void> _loadWords() async {
    _words = await WordService().loadWords();
    _nextWord();
  }

  List<GermanWord> getWords() {
    return _words;
  }

  void _nextWord() {
    if (_words.isNotEmpty) {
      state = _words.removeAt(0);
    } else {
      // Alle Wörter wurden verwendet
    }
  }

  void checkAnswer(String selectedArticle) {
    if (selectedArticle == state.article) {
      // Korrekt
      ref.read(progressProvider.notifier).incrementCorrect();
    } else {
      // Falsch
      ref.read(progressProvider.notifier).incrementIncorrect();
    }
    _nextWord();
  }
}
