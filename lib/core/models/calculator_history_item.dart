class CalculatorHistoryItem {
  final String id;
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculatorHistoryItem({
    required this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CalculatorHistoryItem.fromJson(Map<dynamic, dynamic> json) {
    return CalculatorHistoryItem(
      id: json['id'] as String,
      expression: json['expression'] as String,
      result: json['result'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

