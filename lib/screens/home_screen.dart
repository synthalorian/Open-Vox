import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/practice_session.dart';
import '../providers/providers.dart';
import '../theme/vox_theme.dart';
import '../widgets/log_session_dialog.dart';
import 'stats_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionsProvider);
    final stats = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VoxLog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsScreen()),
            ),
            tooltip: 'Statistics',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats cards
          Row(
            children: [
              _StatCard(
                icon: Icons.local_fire_department,
                label: 'Streak',
                value: '${stats.currentStreak}',
                suffix: 'days',
                color: VoxTheme.streak,
              ),
              const SizedBox(width: 12),
              _StatCard(
                icon: Icons.timer,
                label: 'This Week',
                value: '${stats.thisWeek.fold<int>(0, (s, e) => s + e.duration.inMinutes)}',
                suffix: 'min',
                color: VoxTheme.accent,
              ),
              const SizedBox(width: 12),
              _StatCard(
                icon: Icons.music_note,
                label: 'Total',
                value: '${stats.totalSessions}',
                suffix: 'sessions',
                color: VoxTheme.success,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Week heatmap
          _WeekHeatmap(sessions: sessions),
          const SizedBox(height: 20),
          // Recent sessions
          Row(
            children: [
              const Text(
                'RECENT SESSIONS',
                style: TextStyle(
                  color: VoxTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Text(
                '${sessions.length} total',
                style: const TextStyle(
                  color: VoxTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (sessions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.music_note, color: VoxTheme.textSecondary, size: 48),
                    SizedBox(height: 12),
                    Text(
                      'No practice sessions yet',
                      style: TextStyle(color: VoxTheme.textPrimary, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap the button below to log your first session',
                      style: TextStyle(color: VoxTheme.textSecondary, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          else
            ...sessions.map((session) => Dismissible(
                  key: Key(session.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed: (_) {
                    ref.read(sessionsProvider.notifier).remove(session.id);
                  },
                  child: _SessionCard(session: session),
                )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const LogSessionDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Log Practice'),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String suffix;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.suffix,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    suffix,
                    style: const TextStyle(
                      color: VoxTheme.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Text(
                label,
                style: const TextStyle(
                  color: VoxTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekHeatmap extends StatelessWidget {
  final List<PracticeSession> sessions;

  const _WeekHeatmap({required this.sessions});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (i) {
            final day = DateTime(
                weekStart.year, weekStart.month, weekStart.day + i);
            final practiced = sessions.any((s) =>
                s.date.year == day.year &&
                s.date.month == day.month &&
                s.date.day == day.day);
            final isToday = day.day == now.day && day.month == now.month;
            return Column(
              children: [
                Text(
                  days[i],
                  style: TextStyle(
                    color: isToday ? VoxTheme.accent : VoxTheme.textSecondary,
                    fontSize: 11,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: practiced ? VoxTheme.accent : VoxTheme.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: isToday
                        ? Border.all(color: VoxTheme.accent, width: 2)
                        : null,
                  ),
                  child: practiced
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final PracticeSession session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Text(session.instrument.emoji,
                style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.category.label,
                    style: const TextStyle(
                      color: VoxTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (session.notes != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      session.notes!,
                      style: const TextStyle(
                        color: VoxTheme.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < session.rating ? Icons.star : Icons.star_border,
                        size: 14,
                        color: i < session.rating
                            ? VoxTheme.streak
                            : VoxTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${session.duration.inMinutes} min',
                  style: const TextStyle(
                    color: VoxTheme.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _relativeDate(session.date),
                  style: const TextStyle(
                    color: VoxTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
                if (session.bpmAchieved != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${session.bpmAchieved} BPM',
                    style: const TextStyle(
                      color: VoxTheme.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _relativeDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }
}
