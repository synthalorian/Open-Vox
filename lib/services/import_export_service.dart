import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../models/practice_session.dart';

class ImportExportService {
  static Future<void> exportSessions(List<PracticeSession> sessions) async {
    final jsonList = sessions.map((s) => s.toJson()).toList();
    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);
    
    await Share.share(
      jsonString,
      subject: 'VoxLog Practice Data Export',
    );
  }

  static Future<List<PracticeSession>?> importSessions() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.single.bytes != null) {
      final content = utf8.decode(result.files.single.bytes!);
      final List<dynamic> jsonList = json.decode(content);
      return jsonList.map((j) => PracticeSession.fromJson(j)).toList();
    }
    return null;
  }
}