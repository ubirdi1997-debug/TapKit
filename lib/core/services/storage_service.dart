import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String notesBoxName = 'notes';
  static const String calculatorHistoryBoxName = 'calculator_history';
  static const String qrHistoryBoxName = 'qr_history';
  static const String settingsBoxName = 'settings';

  static Future<void> init() async {
    // Notes will be stored as a box
    await Hive.openBox(notesBoxName);
    await Hive.openBox(calculatorHistoryBoxName);
    await Hive.openBox(qrHistoryBoxName);
    await Hive.openBox(settingsBoxName);
  }

  static Box get notesBox => Hive.box(notesBoxName);
  static Box get calculatorHistoryBox => Hive.box(calculatorHistoryBoxName);
  static Box get qrHistoryBox => Hive.box(qrHistoryBoxName);
  static Box get settingsBox => Hive.box(settingsBoxName);
}

