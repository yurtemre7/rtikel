import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/classes/german_word.dart';
import 'package:rtikel/providers/progress_provider.dart';
import 'package:rtikel/services/word_service.dart';

final b1wordProvider = StateNotifierProvider<WordNotifier, GermanWord>((ref) {
  return WordNotifier(ref);
});

class WordNotifier extends StateNotifier<GermanWord> {
  final Ref ref;
  List<GermanWord> _b1Words = [];

  WordNotifier(this.ref) : super(GermanWord(word: '', article: '')) {
    _loadWords();
  }

  Future<void> _loadWords() async {
    _b1Words = await WordService().loadB1Words();
    _nextB1Word();
  }

  List<GermanWord> getWords() {
    return _b1Words;
  }

  void _nextB1Word() {
    if (_b1Words.isNotEmpty) {
      state = _b1Words.removeAt(0);
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
    _nextB1Word();
  }
}
