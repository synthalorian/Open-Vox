import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_vox/theme/vox_theme.dart';

void main() {
  testWidgets('VoxTheme darkTheme applies correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: VoxTheme.darkTheme,
        home: const Scaffold(body: Text('VoxLog')),
      ),
    );
    expect(find.text('VoxLog'), findsOneWidget);
  });
}
