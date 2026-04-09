import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/session_repository.dart';
import 'theme/vox_theme.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionRepository.init();
  runApp(const ProviderScope(child: VoxLogApp()));
}

class VoxLogApp extends StatelessWidget {
  const VoxLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Vox',
      debugShowCheckedModeBanner: false,
      theme: VoxTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
