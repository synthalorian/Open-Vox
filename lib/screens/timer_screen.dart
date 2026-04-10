import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/practice_session.dart';
import '../providers/providers.dart';
import '../theme/vox_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  Instrument _instrument = Instrument.electricGuitar;
  PracticeCategory _category = PracticeCategory.technique;
  
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool _isRunning = false;

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
      } else {
        _stopwatch.start();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {});
        });
      }
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    setState(() {
      _stopwatch.stop();
      _stopwatch.reset();
      _timer?.cancel();
      _isRunning = false;
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return hours == "00" ? "$minutes:$seconds" : "$hours:$minutes:$seconds";
  }

  Future<void> _finishSession() async {
    final duration = _stopwatch.elapsed;
    if (duration.inMinutes < 1) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('SESSION TOO SHORT'),
          content: const Text('Practice sessions under 1 minute are not logged. Continue anyway?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('BACK')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('DISCARD')),
          ],
        ),
      );
      if (confirm == true) Navigator.pop(context);
      return;
    }

    final session = PracticeSession(
      id: const Uuid().v4(),
      date: DateTime.now(),
      instrument: _instrument,
      category: _category,
      duration: duration,
      rating: 3,
    );

    await ref.read(sessionsProvider.notifier).add(session);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('LOGGED: ${duration.inMinutes} MIN ON ${_instrument.label.toUpperCase()}'),
          backgroundColor: VoxTheme.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PRACTICE TIMER')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Instrument selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  DropdownButton<Instrument>(
                    value: _instrument,
                    dropdownColor: VoxTheme.surface,
                    isExpanded: true,
                    style: const TextStyle(color: VoxTheme.accent, fontWeight: FontWeight.bold),
                    items: Instrument.values.map((inst) {
                      return DropdownMenuItem(
                        value: inst,
                        child: Text('${inst.emoji} ${inst.label.toUpperCase()}'),
                      );
                    }).toList(),
                    onChanged: _isRunning ? null : (v) => setState(() => _instrument = v!),
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<PracticeCategory>(
                    value: _category,
                    dropdownColor: VoxTheme.surface,
                    isExpanded: true,
                    style: const TextStyle(color: VoxTheme.textSecondary, fontWeight: FontWeight.bold),
                    items: PracticeCategory.values.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat.label.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: _isRunning ? null : (v) => setState(() => _category = v!),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Timer Display
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isRunning ? VoxTheme.neonPink : VoxTheme.divider,
                  width: 4,
                ),
                boxShadow: _isRunning ? [
                  BoxShadow(
                    color: VoxTheme.neonPink.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ] : [],
              ),
              child: Text(
                _formatDuration(_stopwatch.elapsed),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'monospace',
                  letterSpacing: -2,
                ),
              ),
            ).animate(target: _isRunning ? 1 : 0).shimmer(duration: 2.seconds),
            const Spacer(),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning && _stopwatch.elapsed.inSeconds > 0)
                  IconButton.filled(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.refresh),
                    style: IconButton.styleFrom(
                      backgroundColor: VoxTheme.surfaceLight,
                      padding: const EdgeInsets.all(16),
                    ),
                  ).animate().scale(),
                const SizedBox(width: 24),
                IconButton.filled(
                  onPressed: _toggleTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  style: IconButton.styleFrom(
                    backgroundColor: _isRunning ? VoxTheme.neonPink : VoxTheme.neonBlue,
                    padding: const EdgeInsets.all(24),
                  ),
                ),
                const SizedBox(width: 24),
                if (!_isRunning && _stopwatch.elapsed.inSeconds > 0)
                  IconButton.filled(
                    onPressed: _finishSession,
                    icon: const Icon(Icons.check),
                    style: IconButton.styleFrom(
                      backgroundColor: VoxTheme.success,
                      padding: const EdgeInsets.all(16),
                    ),
                  ).animate().scale(),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}