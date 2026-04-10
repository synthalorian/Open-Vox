import 'package:flutter_test/flutter_test.dart';
import 'package:open_vox/models/practice_session.dart';

void main() {
  group('PracticeStats Tests', () {
    test('currentStreak should be 0 when no sessions', () {
      final stats = PracticeStats([]);
      expect(stats.currentStreak, 0);
    });

    test('currentStreak should be 1 when practiced today only', () {
      final now = DateTime.now();
      final stats = PracticeStats([
        _session(now, '1'),
      ]);
      expect(stats.currentStreak, 1);
    });

    test('currentStreak should be 1 when practiced yesterday only', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final stats = PracticeStats([
        _session(yesterday, '1'),
      ]);
      expect(stats.currentStreak, 1);
    });

    test('currentStreak should be 2 when practiced today and yesterday', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final stats = PracticeStats([
        _session(now, '1'),
        _session(yesterday, '2'),
      ]);
      expect(stats.currentStreak, 2);
    });

    test('currentStreak should handle multiple sessions on same day', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final stats = PracticeStats([
        _session(now, '1'),
        _session(now.subtract(const Duration(hours: 2)), '2'),
        _session(yesterday, '3'),
      ]);
      expect(stats.currentStreak, 2);
    });

    test('currentStreak should break when a day is missed', () {
      final now = DateTime.now();
      final twoDaysAgo = now.subtract(const Duration(days: 2));
      final stats = PracticeStats([
        _session(now, '1'),
        _session(twoDaysAgo, '2'),
      ]);
      expect(stats.currentStreak, 1); // Only today
    });

    test('totalTime should sum durations correctly', () {
      final stats = PracticeStats([
        _session(DateTime.now(), '1', minutes: 30),
        _session(DateTime.now(), '2', minutes: 45),
      ]);
      expect(stats.totalTime.inMinutes, 75);
    });
  });
}

PracticeSession _session(DateTime date, String id, {int minutes = 30}) {
  return PracticeSession(
    id: id,
    date: date,
    instrument: Instrument.electricGuitar,
    category: PracticeCategory.technique,
    duration: Duration(minutes: minutes),
  );
}