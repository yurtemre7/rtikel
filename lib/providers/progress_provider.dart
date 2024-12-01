import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final progressProvider = StateNotifierProvider<ProgressNotifier, ProgressState>((ref) {
  return ProgressNotifier();
});

class ProgressState {
  final int correct;
  final int incorrect;

  ProgressState({required this.correct, required this.incorrect});
}

class ProgressNotifier extends StateNotifier<ProgressState> {
  ProgressNotifier() : super(ProgressState(correct: 0, incorrect: 0));

  void incrementCorrect() {
    state = ProgressState(correct: state.correct + 1, incorrect: state.incorrect);
    _saveProgress();
  }

  void incrementIncorrect() {
    state = ProgressState(correct: state.correct, incorrect: state.incorrect + 1);
    _saveProgress();
  }

  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('correct', state.correct);
    prefs.setInt('incorrect', state.incorrect);
  }

  Future<void> loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int correct = prefs.getInt('correct') ?? 0;
    int incorrect = prefs.getInt('incorrect') ?? 0;
    state = ProgressState(correct: correct, incorrect: incorrect);
  }
}
