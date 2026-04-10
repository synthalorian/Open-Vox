import 'package:freezed_annotation/freezed_annotation.dart';

part 'practice_session.freezed.dart';
part 'practice_session.g.dart';

enum Instrument {
  @JsonValue('electric_guitar')
  electricGuitar('Electric Guitar', '🎸'),
  @JsonValue('acoustic_guitar')
  acousticGuitar('Acoustic Guitar', '🪕'),
  @JsonValue('bass')
  bass('Bass', '🎸'),
  @JsonValue('piano')
  piano('Piano/Keys', '🎹'),
  @JsonValue('drums')
  drums('Drums', '🥁'),
  @JsonValue('vocals')
  vocals('Vocals', '🎤'),
  @JsonValue('other')
  other('Other', '🎵');

  final String label;
  final String emoji;
  const Instrument(this.label, this.emoji);
}

enum PracticeCategory {
  @JsonValue('technique')
  technique('Technique'),
  @JsonValue('songs')
  songs('Songs/Repertoire'),
  @JsonValue('theory')
  theory('Theory'),
  @JsonValue('improvisation')
  improvisation('Improvisation'),
  @JsonValue('ear_training')
  earTraining('Ear Training'),
  @JsonValue('sight_reading')
  sightReading('Sight Reading'),
  @JsonValue('recording')
  recording('Recording'),
  @JsonValue('jamming')
  jamming('Jamming'),
  @JsonValue('warmup')
  warmup('Warm-up'),
  @JsonValue('other')
  other('Other');

  final String label;
  const PracticeCategory(this.label);
}

@freezed
class PracticeSession with _$PracticeSession {
  const factory PracticeSession({
    required String id,
    required DateTime date,
    required Instrument instrument,
    required PracticeCategory category,
    required Duration duration,
    String? notes,
    int? bpmGoal,
    int? bpmAchieved,
    @Default(3) int rating,
    @Default([]) List<String> tags,
  }) = _PracticeSession;

  factory PracticeSession.fromJson(Map<String, dynamic> json) =>
      _$PracticeSessionFromJson(json);
}

class PracticeStats {
  final List<PracticeSession> sessions;

  PracticeStats(this.sessions);

  int get totalSessions => sessions.length;

  Duration get totalTime => sessions.fold(
        Duration.zero,
        (sum, s) => sum + s.duration,
      );

  int get currentStreak {
    if (sessions.isEmpty) return 0;
    
    final sorted = List<PracticeSession>.from(sessions)
      ..sort((a, b) => b.date.compareTo(a.date));

    final dates = sorted
        .map((s) => DateTime(s.date.year, s.date.month, s.date.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    var check = DateTime.now();
    check = DateTime(check.year, check.month, check.day);

    for (final date in dates) {
      final diff = check.difference(date).inDays;
      if (diff == 0) {
        streak++;
        // Keep check as is for next iteration if it was today
      } else if (diff == 1) {
        streak++;
        check = date;
      } else if (diff > 1) {
        break;
      }
    }
    return streak;
  }

  Map<Instrument, Duration> get timeByInstrument {
    final map = <Instrument, Duration>{};
    for (final s in sessions) {
      map[s.instrument] = (map[s.instrument] ?? Duration.zero) + s.duration;
    }
    return map;
  }

  Map<PracticeCategory, int> get sessionsByCategory {
    final map = <PracticeCategory, int>{};
    for (final s in sessions) {
      map[s.category] = (map[s.category] ?? 0) + 1;
    }
    return map;
  }

  double get averageRating {
    if (sessions.isEmpty) return 0;
    return sessions.fold<int>(0, (s, e) => s + e.rating) / sessions.length;
  }

  List<PracticeSession> get thisWeek {
    final now = DateTime.now();
    // Monday is 1, Sunday is 7 in DateTime.weekday
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return sessions.where((s) => s.date.isAfter(start) || s.date.isAtSameMomentAs(start)).toList();
  }
}