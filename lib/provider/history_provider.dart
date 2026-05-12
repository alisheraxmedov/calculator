import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HistoryItem {
  final String expression;
  final String result;
  final DateTime timestamp;

  const HistoryItem({
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

  static HistoryItem? tryFromJson(Object? raw) {
    if (raw is! Map) return null;
    final expression = raw['expression'];
    final result = raw['result'];
    final timestamp = raw['timestamp'];
    if (expression is! String || result is! String || timestamp is! String) {
      return null;
    }
    final parsed = DateTime.tryParse(timestamp);
    if (parsed == null) return null;
    return HistoryItem(
      expression: expression,
      result: result,
      timestamp: parsed,
    );
  }
}

class HistoryProvider extends ChangeNotifier {
  static const int _maxItems = 50;
  static const String _storageKey = 'calculator_history';

  final GetStorage _box = GetStorage();
  List<HistoryItem> _history = [];

  List<HistoryItem> get history => _history;

  HistoryProvider() {
    _loadHistory();
  }

  void _loadHistory() {
    final raw = _box.read<List<dynamic>>(_storageKey);
    if (raw == null) return;
    final loaded = <HistoryItem>[];
    for (final item in raw) {
      final parsed = HistoryItem.tryFromJson(item);
      if (parsed != null) loaded.add(parsed);
    }
    loaded.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    _history = loaded;
    // Listener'lar hali ulanmagan — notifyListeners chaqirilmaydi.
  }

  void addHistory(String expression, String result) {
    _history.insert(
      0,
      HistoryItem(
        expression: expression,
        result: result,
        timestamp: DateTime.now(),
      ),
    );
    if (_history.length > _maxItems) {
      _history = _history.take(_maxItems).toList();
    }
    _saveHistory();
    notifyListeners();
  }

  void _saveHistory() {
    _box.write(_storageKey, _history.map((item) => item.toJson()).toList());
  }

  void clearHistory() {
    _history.clear();
    _box.remove(_storageKey);
    notifyListeners();
  }

  void deleteHistoryItem(int index) {
    if (index < 0 || index >= _history.length) return;
    _history.removeAt(index);
    _saveHistory();
    notifyListeners();
  }

  String getResultByIndex(int index) {
    if (index < 0 || index >= _history.length) return '';
    return _history[index].result;
  }
}
