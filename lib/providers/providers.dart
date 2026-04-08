import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/practice_session.dart';
import '../services/session_repository.dart';

final sessionRepoProvider = Provider<SessionRepository>((ref) {
  return SessionRepository();
});

final sessionsProvider =
    StateNotifierProvider<SessionsNotifier, List<PracticeSession>>((ref) {
  final repo = ref.read(sessionRepoProvider);
  return SessionsNotifier(repo);
});

class SessionsNotifier extends StateNotifier<List<PracticeSession>> {
  final SessionRepository _repo;

  SessionsNotifier(this._repo) : super(_repo.getAll());

  Future<void> add(PracticeSession session) async {
    await _repo.save(session);
    state = _repo.getAll();
  }

  Future<void> remove(String id) async {
    await _repo.delete(id);
    state = _repo.getAll();
  }

  void refresh() {
    state = _repo.getAll();
  }
}

final statsProvider = Provider<PracticeStats>((ref) {
  final sessions = ref.watch(sessionsProvider);
  return PracticeStats(sessions);
});
