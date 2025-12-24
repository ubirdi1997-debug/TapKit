import 'package:flutter/foundation.dart';
import '../../../core/models/calculator_history_item.dart';
import '../../../core/services/storage_service.dart';

class CalculatorProvider with ChangeNotifier {
  String _display = '0';
  String _expression = '';
  String _currentNumber = '0';
  String _operator = '';
  bool _shouldResetDisplay = false;
  
  List<CalculatorHistoryItem> _history = [];

  String get display => _display;
  String get expression => _expression;
  List<CalculatorHistoryItem> get history => List.unmodifiable(_history);

  CalculatorProvider() {
    _loadHistory();
  }

  void _loadHistory() {
    final box = StorageService.calculatorHistoryBox;
    _history = box.values
        .map((item) => CalculatorHistoryItem.fromJson(item as Map))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    notifyListeners();
  }

  void inputNumber(String number) {
    if (_shouldResetDisplay) {
      _display = '0';
      _currentNumber = '0';
      _shouldResetDisplay = false;
    }

    if (_display == '0') {
      _display = number;
      _currentNumber = number;
    } else {
      _display += number;
      _currentNumber += number;
    }
    notifyListeners();
  }

  void inputOperator(String op) {
    if (_expression.isNotEmpty && _operator.isNotEmpty) {
      _calculate();
    }

    _expression = _display;
    _operator = op;
    _currentNumber = '';
    _shouldResetDisplay = true;
    notifyListeners();
  }

  void inputDecimal() {
    if (_shouldResetDisplay) {
      _display = '0';
      _currentNumber = '0';
      _shouldResetDisplay = false;
    }

    if (!_currentNumber.contains('.')) {
      _display += '.';
      _currentNumber += '.';
      notifyListeners();
    }
  }

  void calculatePercentage() {
    try {
      final value = double.parse(_currentNumber.isEmpty ? _display : _currentNumber);
      final result = value / 100;
      _display = _formatNumber(result);
      _currentNumber = _display;
      _expression = '';
      _operator = '';
      _shouldResetDisplay = true;
      _saveToHistory('${value}%', _display);
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      notifyListeners();
    }
  }

  void calculateGST() {
    try {
      final value = double.parse(_currentNumber.isEmpty ? _display : _currentNumber);
      final gstAmount = value * 0.18; // 18% GST
      final total = value + gstAmount;
      _display = _formatNumber(total);
      _currentNumber = _display;
      _expression = '${_formatNumber(value)} + GST (18%)';
      _operator = '';
      _shouldResetDisplay = true;
      _saveToHistory(_expression, _display);
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      notifyListeners();
    }
  }

  void calculate() {
    if (_operator.isEmpty || _expression.isEmpty) return;
    _calculate();
  }

  void _calculate() {
    try {
      if (_currentNumber.isEmpty) return;

      final num1 = double.parse(_expression);
      final num2 = double.parse(_currentNumber);
      double result = 0;

      switch (_operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '×':
          result = num1 * num2;
          break;
        case '÷':
          if (num2 == 0) {
            _display = 'Error';
            _clear();
            notifyListeners();
            return;
          }
          result = num1 / num2;
          break;
        default:
          return;
      }

      final expressionStr = '$_expression $_operator $_currentNumber';
      _display = _formatNumber(result);
      _currentNumber = _display;
      _expression = '';
      _operator = '';
      _shouldResetDisplay = true;

      _saveToHistory(expressionStr, _display);
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      notifyListeners();
    }
  }

  void clear() {
    _clear();
    notifyListeners();
  }

  void _clear() {
    _display = '0';
    _expression = '';
    _currentNumber = '0';
    _operator = '';
    _shouldResetDisplay = false;
  }

  void clearEntry() {
    if (_shouldResetDisplay) {
      _clear();
    } else {
      _display = '0';
      _currentNumber = '0';
    }
    notifyListeners();
  }

  void deleteLast() {
    if (_shouldResetDisplay) return;

    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
      _currentNumber = _currentNumber.substring(0, _currentNumber.length - 1);
    } else {
      _display = '0';
      _currentNumber = '0';
    }
    notifyListeners();
  }

  String _formatNumber(double number) {
    if (number % 1 == 0) {
      return number.toInt().toString();
    } else {
      // Limit decimal places
      return number.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
  }

  void _saveToHistory(String expression, String result) {
    final item = CalculatorHistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );

    final box = StorageService.calculatorHistoryBox;
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
  }

  void clearHistory() {
    final box = StorageService.calculatorHistoryBox;
    box.clear();
    _history.clear();
    notifyListeners();
  }

  String getCurrentResult() {
    return _display;
  }

  void setValue(String value) {
    try {
      // Validate that it's a number
      double.parse(value);
      _display = value;
      _currentNumber = value;
      _expression = '';
      _operator = '';
      _shouldResetDisplay = false;
      notifyListeners();
    } catch (e) {
      // Invalid number, ignore
    }
  }
}

