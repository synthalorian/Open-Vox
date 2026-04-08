import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/practice_session.dart';
import '../providers/providers.dart';
import '../theme/vox_theme.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: stats.totalSessions == 0
          ? const Center(
              child: Text(
                'No sessions logged yet',
                style: TextStyle(color: VoxTheme.textSecondary),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Overview
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header('Overview'),
                        const SizedBox(height: 12),
                        _statRow('Total Sessions', '${stats.totalSessions}'),
                        _statRow('Total Time',
                            '${stats.totalTime.inHours}h ${stats.totalTime.inMinutes % 60}m'),
                        _statRow('Current Streak',
                            '${stats.currentStreak} day${stats.currentStreak == 1 ? '' : 's'}'),
                        _statRow('Average Rating',
                            '${stats.averageRating.toStringAsFixed(1)} / 5'),
                        _statRow('This Week',
                            '${stats.thisWeek.length} session${stats.thisWeek.length == 1 ? '' : 's'}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Time by instrument
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header('Time by Instrument'),
                        const SizedBox(height: 12),
                        ...stats.timeByInstrument.entries.map((e) {
                          final pct = stats.totalTime.inMinutes > 0
                              ? e.value.inMinutes / stats.totalTime.inMinutes
                              : 0.0;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(e.key.emoji,
                                        style: const TextStyle(fontSize: 16)),
                                    const SizedBox(width: 8),
                                    Text(
                                      e.key.label,
                                      style: const TextStyle(
                                        color: VoxTheme.textPrimary,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${e.value.inMinutes} min',
                                      style: const TextStyle(
                                        color: VoxTheme.accent,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: LinearProgressIndicator(
                                    value: pct,
                                    minHeight: 6,
                                    backgroundColor: VoxTheme.surfaceLight,
                                    valueColor:
                                        const AlwaysStoppedAnimation(VoxTheme.accent),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Sessions by category
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header('Sessions by Category'),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: stats.sessionsByCategory.entries.map((e) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: VoxTheme.accent.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${e.key.label}: ${e.value}',
                                style: const TextStyle(
                                  color: VoxTheme.accentLight,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _header(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: VoxTheme.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  color: VoxTheme.textSecondary, fontSize: 13)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  color: VoxTheme.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
