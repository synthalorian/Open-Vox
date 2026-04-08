enum Instrument {
  electricGuitar('Electric Guitar', '🎸'),
  acousticGuitar('Acoustic Guitar', '🪕'),
  bass('Bass', '🎸'),
  piano('Piano/Keys', '🎹'),
  drums('Drums', '🥁'),
  vocals('Vocals', '🎤'),
  other('Other', '🎵');

  final String label;
  final String emoji;
  const Instrument(this.label, this.emoji);
}

enum PracticeCategory {
  technique('Technique'),
  songs('Songs/Repertoire'),
  theory('Theory'),
  improvisation('Improvisation'),
  earTraining('Ear Training'),
  sightReading('Sight Reading'),
  recording('Recording'),
  jamming('Jamming'),
  warmup('Warm-up'),
  other('Other');

  final String label;
  const PracticeCategory(this.label);
}

class PracticeSession {
  final String id;
  final DateTime date;
  final Instrument instrument;
  final PracticeCategory category;
  final Duration duration;
  final String? notes;
  final int? bpmGoal;
  final int? bpmAchieved;
  final int rating; // 1-5 stars
  final List<String> tags;

  PracticeSession({
    required this.id,
    required this.date,
    required this.instrument,
    required this.category,
    required this.duration,
    this.notes,
    this.bpmGoal,
    this.bpmAchieved,
    this.rating = 3,
    List<String>? tags,
  }) : tags = tags ?? [];

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'instrument': instrument.index,
        'category': category.index,
        'durationMinutes': duration.inMinutes,
        'notes': notes,
        'bpmGoal': bpmGoal,
        'bpmAchieved': bpmAchieved,
        'rating': rating,
        'tags': tags,
      };

  factory PracticeSession.fromMap(Map<dynamic, dynamic> map) {
    return PracticeSession(
      id: map['id'] as String,
      date: DateTime.parse(map['date'] as String),
      instrument: Instrument.values[map['instrument'] as int],
      category: PracticeCategory.values[map['category'] as int],
      duration: Duration(minutes: map['durationMinutes'] as int),
      notes: map['notes'] as String?,
      bpmGoal: map['bpmGoal'] as int?,
      bpmAchieved: map['bpmAchieved'] as int?,
      rating: map['rating'] as int? ?? 3,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }
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
      if (diff <= 1) {
        streak++;
        check = date;
      } else {
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
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return sessions.where((s) => s.date.isAfter(start)).toList();
  }
}
