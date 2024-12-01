import 'package:flutter/services.dart';
import 'package:rtikel/classes/german_word.dart';

class WordService {
  Future<List<GermanWord>> loadWords() async {
    List<GermanWord> words = [];

    // Laden der Dateien aus Assets
    String derWords = await rootBundle.loadString('assets/der.txt');
    String dieWords = await rootBundle.loadString('assets/die.txt');
    String dasWords = await rootBundle.loadString('assets/das.txt');

    // Verarbeitung und Hinzufügen zur Liste
    words.addAll(_parseWords(derWords, 'der'));
    words.addAll(_parseWords(dieWords, 'die'));
    words.addAll(_parseWords(dasWords, 'das'));

    words.shuffle(); // Optional: Wörter mischen
    return words;
  }

  List<GermanWord> _parseWords(String content, String article) {
    return content
        .split('\n')
        .map((word) => GermanWord(word: word.trim(), article: article))
        .toList();
  }
}
