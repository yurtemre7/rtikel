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

  Future<List<GermanWord>> loadB1Words() async {
    List<GermanWord> words = [];

    String b1Words = await rootBundle.loadString('assets/b1.txt');

    words.addAll(_parseWordsDelim(b1Words));

    words.shuffle();
    return words;
  }

  List<GermanWord> _parseWordsDelim(String content) {
    return content.split('\n').map((line) {
      var parts = line.trim().split(" ");
      assert(parts.length == 2);
      return GermanWord(word: parts.last, article: parts.first);
    }).toList();
  }

  List<GermanWord> _parseWords(String content, String article) {
    return content
        .split('\n')
        .map((word) => GermanWord(word: word.trim(), article: article))
        .toList();
  }
}
