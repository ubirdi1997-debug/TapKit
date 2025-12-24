class QrScanItem {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isUrl;

  QrScanItem({
    required this.id,
    required this.content,
    required this.timestamp,
    this.isUrl = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isUrl': isUrl,
    };
  }

  factory QrScanItem.fromJson(Map<dynamic, dynamic> json) {
    return QrScanItem(
      id: json['id'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isUrl: json['isUrl'] as bool? ?? false,
    );
  }
}

