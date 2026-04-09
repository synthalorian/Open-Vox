import 'package:flutter_test/flutter_test.dart';
import 'package:open_vox/models/practice_session.dart';

void main() {
  group('Instrument', () {
    test('has labels and emojis', () {
      for (final inst in Instrument.values) {
        expect(inst.label, isNotEmpty);
        expect(inst.emoji, isNotEmpty);
      }
    });
  });

  group('PracticeCategory', () {
    test('has labels', () {
      for (final cat in PracticeCategory.values) {
        expect(cat.label, isNotEmpty);
      }
    });
  });

  group('PracticeSession', () {
    test('creates with defaults', () {
      final session = PracticeSession(
        id: 'test-1',
        date: DateTime.now(),
        instrument: Instrument.electricGuitar,
        category: PracticeCategory.technique,
        duration: const Duration(minutes: 30),
      );
      expect(session.rating, 3);
      expect(session.tags, isEmpty);
      expect(session.notes, isNull);
      expect(session.bpmGoal, isNull);
    });

    test('round-trips through Map', () {
      final session = PracticeSession(
        id: 'test-2',
        date: DateTime(2026, 4, 8, 14, 30),
        instrument: Instrument.acousticGuitar,
        category: PracticeCategory.songs,
        duration: const Duration(minutes: 45),
        notes: 'Fingerpicking',
        bpmGoal: 120,
        bpmAchieved: 115,
        rating: 4,
        tags: ['worship'],
      );
      final restored = PracticeSession.fromMap(session.toMap());
      expect(restored.id, session.id);
      expect(restored.instrument, session.instrument);
      expect(restored.category, session.category);
      expect(restored.duration.inMinutes, 45);
      expect(restored.notes, 'Fingerpicking');
      expect(restored.bpmGoal, 120);
      expect(restored.bpmAchieved, 115);
      expect(restored.rating, 4);
      expect(restored.tags, ['worship']);
    });
  });

  group('PracticeStats', () {
    test('empty stats', () {
      final stats = PracticeStats([]);
      expect(stats.totalSessions, 0);
      expect(stats.totalTime, Duration.zero);
      expect(stats.currentStreak, 0);
      expect(stats.averageRating, 0);
    });

    test('calculates totals', () {
      final stats = PracticeStats([
        PracticeSession(
          id: '1',
          date: DateTime.now(),
          instrument: Instrument.electricGuitar,
          category: PracticeCategory.technique,
          duration: const Duration(minutes: 30),
          rating: 4,
        ),
        PracticeSession(
          id: '2',
          date: DateTime.now(),
          instrument: Instrument.piano,
          category: PracticeCategory.songs,
          duration: const Duration(minutes: 60),
          rating: 5,
        ),
      ]);
      expect(stats.totalSessions, 2);
      expect(stats.totalTime.inMinutes, 90);
      expect(stats.averageRating, 4.5);
    });

    test('time by instrument', () {
      final stats = PracticeStats([
        PracticeSession(
          id: '1',
          date: DateTime.now(),
          instrument: Instrument.electricGuitar,
          category: PracticeCategory.technique,
          duration: const Duration(minutes: 30),
        ),
        PracticeSession(
          id: '2',
          date: DateTime.now(),
          instrument: Instrument.electricGuitar,
          category: PracticeCategory.songs,
          duration: const Duration(minutes: 20),
        ),
        PracticeSession(
          id: '3',
          date: DateTime.now(),
          instrument: Instrument.piano,
          category: PracticeCategory.theory,
          duration: const Duration(minutes: 45),
        ),
      ]);
      final byInst = stats.timeByInstrument;
      expect(byInst[Instrument.electricGuitar]!.inMinutes, 50);
      expect(byInst[Instrument.piano]!.inMinutes, 45);
    });

    test('sessions by category', () {
      final stats = PracticeStats([
        PracticeSession(
          id: '1',
          date: DateTime.now(),
          instrument: Instrument.electricGuitar,
          category: PracticeCategory.technique,
          duration: const Duration(minutes: 30),
        ),
        PracticeSession(
          id: '2',
          date: DateTime.now(),
          instrument: Instrument.electricGuitar,
          category: PracticeCategory.technique,
          duration: const Duration(minutes: 30),
        ),
        PracticeSession(
          id: '3',
          date: DateTime.now(),
          instrument: Instrument.piano,
          category: PracticeCategory.songs,
          duration: const Duration(minutes: 30),
        ),
      ]);
      expect(stats.sessionsByCategory[PracticeCategory.technique], 2);
      expect(stats.sessionsByCategory[PracticeCategory.songs], 1);
    });
  });
}
