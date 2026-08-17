import 'package:birdle/game.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('registers a valid guess in the next empty slot', () {
    final game = Game();

    final result = game.guess('aback');

    expect(result.toString(), 'aback');
    expect(game.activeIndex, 1);
    expect(game.previousGuess.toString(), 'aback');
  });

  test('ignores invalid guesses instead of crashing or registering them', () {
    final game = Game();

    final result = game.guess('abc');

    expect(result.toString(), '');
    expect(game.activeIndex, 0);
    expect(game.previousGuess.toString(), '');
  });
}
