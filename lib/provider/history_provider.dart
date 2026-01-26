import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HistoryItem {
  final String expression;
  final String result;
  final DateTime timestamp;

  HistoryItem({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      expression: json['expression'],
      result: json['result'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class HistoryProvider extends ChangeNotifier {
  final box = GetStorage();
  List<HistoryItem> _history = [];

  List<HistoryItem> get history => _history;

  HistoryProvider() {
    _loadHistory();
  }

  void _loadHistory() {
    final List<dynamic>? historyData = box.read<List<dynamic>>('calculator_history');
    if (historyData != null) {
      _history = historyData
          .map((item) => HistoryItem.fromJson(item))
          .toList();
      _history.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }
    notifyListeners();
  }

  void addHistory(String expression, String result) {
    final historyItem = HistoryItem(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );
    
    _history.insert(0, historyItem);
    
    // Faqat oxirgi 50 ta hisob-kitobni saqlaymiz
    if (_history.length > 50) {
      _history = _history.take(50).toList();
    }
    
    _saveHistory();
    notifyListeners();
  }

  void _saveHistory() {
    final historyData = _history.map((item) => item.toJson()).toList();
    box.write('calculator_history', historyData);
  }

  void clearHistory() {
    _history.clear();
    box.remove('calculator_history');
    notifyListeners();
  }

  void deleteHistoryItem(int index) {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      _saveHistory();
      notifyListeners();
    }
  }

  // History dan result qiymatini olish
  String getResultByIndex(int index) {
    if (index >= 0 && index < _history.length) {
      return _history[index].result;
    }
    return '';
  }
}
