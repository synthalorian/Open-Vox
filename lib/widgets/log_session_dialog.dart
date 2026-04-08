import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/practice_session.dart';
import '../providers/providers.dart';
import '../theme/vox_theme.dart';

class LogSessionDialog extends ConsumerStatefulWidget {
  const LogSessionDialog({super.key});

  @override
  ConsumerState<LogSessionDialog> createState() => _LogSessionDialogState();
}

class _LogSessionDialogState extends ConsumerState<LogSessionDialog> {
  Instrument _instrument = Instrument.electricGuitar;
  PracticeCategory _category = PracticeCategory.technique;
  int _minutes = 30;
  int _rating = 3;
  int? _bpmGoal;
  int? _bpmAchieved;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: VoxTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log Practice',
                  style: TextStyle(
                    color: VoxTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Instrument
                _label('Instrument'),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: Instrument.values.map((inst) {
                    final selected = _instrument == inst;
                    return ChoiceChip(
                      label: Text('${inst.emoji} ${inst.label}'),
                      selected: selected,
                      onSelected: (_) => setState(() => _instrument = inst),
                      selectedColor: VoxTheme.accent.withOpacity(0.3),
                      labelStyle: TextStyle(
                        color: selected ? VoxTheme.accent : VoxTheme.textSecondary,
                        fontSize: 12,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                // Category
                _label('Category'),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: PracticeCategory.values.map((cat) {
                    final selected = _category == cat;
                    return ChoiceChip(
                      label: Text(cat.label),
                      selected: selected,
                      onSelected: (_) => setState(() => _category = cat),
                      selectedColor: VoxTheme.accent.withOpacity(0.3),
                      labelStyle: TextStyle(
                        color: selected ? VoxTheme.accent : VoxTheme.textSecondary,
                        fontSize: 12,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                // Duration
                _label('Duration'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          setState(() => _minutes = (_minutes - 5).clamp(5, 480)),
                      icon: const Icon(Icons.remove, size: 18),
                    ),
                    Text(
                      '$_minutes min',
                      style: const TextStyle(
                        color: VoxTheme.accent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          setState(() => _minutes = (_minutes + 5).clamp(5, 480)),
                      icon: const Icon(Icons.add, size: 18),
                    ),
                    const Spacer(),
                    // Quick presets
                    for (final m in [15, 30, 45, 60])
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: GestureDetector(
                          onTap: () => setState(() => _minutes = m),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _minutes == m
                                  ? VoxTheme.accent.withOpacity(0.2)
                                  : VoxTheme.surfaceLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${m}m',
                              style: TextStyle(
                                color: _minutes == m
                                    ? VoxTheme.accent
                                    : VoxTheme.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                // Rating
                _label('Rating'),
                Row(
                  children: List.generate(5, (i) {
                    return GestureDetector(
                      onTap: () => setState(() => _rating = i + 1),
                      child: Icon(
                        i < _rating ? Icons.star : Icons.star_border,
                        color: i < _rating
                            ? VoxTheme.streak
                            : VoxTheme.textSecondary,
                        size: 28,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 14),
                // BPM (optional)
                _label('BPM (optional)'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: VoxTheme.textPrimary, fontSize: 13),
                        decoration: _inputDecor('Goal'),
                        onChanged: (v) => _bpmGoal = int.tryParse(v),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: VoxTheme.textPrimary, fontSize: 13),
                        decoration: _inputDecor('Achieved'),
                        onChanged: (v) => _bpmAchieved = int.tryParse(v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Notes
                _label('Notes'),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  style: const TextStyle(
                      color: VoxTheme.textPrimary, fontSize: 13),
                  decoration: _inputDecor('What did you work on?'),
                ),
                const SizedBox(height: 20),
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: VoxTheme.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  InputDecoration _inputDecor(String hint) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: const TextStyle(color: VoxTheme.textSecondary, fontSize: 12),
      filled: true,
      fillColor: VoxTheme.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(12),
    );
  }

  Future<void> _save() async {
    final session = PracticeSession(
      id: const Uuid().v4(),
      date: DateTime.now(),
      instrument: _instrument,
      category: _category,
      duration: Duration(minutes: _minutes),
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      bpmGoal: _bpmGoal,
      bpmAchieved: _bpmAchieved,
      rating: _rating,
    );

    await ref.read(sessionsProvider.notifier).add(session);
    if (mounted) Navigator.pop(context);
  }
}
