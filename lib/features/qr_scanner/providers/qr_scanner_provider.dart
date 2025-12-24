import 'package:flutter/foundation.dart';
import '../../../core/models/qr_scan_item.dart';
import '../../../core/services/storage_service.dart';

class QrScannerProvider with ChangeNotifier {
  List<QrScanItem> _history = [];

  List<QrScanItem> get history => List.unmodifiable(_history);

  QrScannerProvider() {
    _loadHistory();
  }

  void _loadHistory() {
    final box = StorageService.qrHistoryBox;
    _history = box.values
        .map((item) => QrScanItem.fromJson(item as Map))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    notifyListeners();
  }

  void addScanResult(String content) {
    final isUrl = _isUrl(content);
    final item = QrScanItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      timestamp: DateTime.now(),
      isUrl: isUrl,
    );

    final box = StorageService.qrHistoryBox;
    box.put(item.id, item.toJson());
    _history.insert(0, item);

    // Keep only last 100 items
    if (_history.length > 100) {
      final toRemove = _history.sublist(100);
      for (var item in toRemove) {
        box.delete(item.id);
      }
      _history = _history.sublist(0, 100);
    }

    notifyListeners();
  }

  bool _isUrl(String text) {
    try {
      final uri = Uri.parse(text);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  void clearHistory() {
    final box = StorageService.qrHistoryBox;
    box.clear();
    _history.clear();
    notifyListeners();
  }
}

