import 'package:hive_flutter/hive_flutter.dart';
import '../models/practice_session.dart';

class SessionRepository {
  static const _boxName = 'practice_sessions';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Box get _box => Hive.box(_boxName);

  Future<void> save(PracticeSession session) async {
    await _box.put(session.id, session.toMap());
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  List<PracticeSession> getAll() {
    return _box.values
        .map((data) =>
            PracticeSession.fromMap(Map<dynamic, dynamic>.from(data)))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  int get count => _box.length;
}
