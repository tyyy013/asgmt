import 'package:flutter/foundation.dart';

class FilterProvider extends ChangeNotifier {
  String _selectedType = 'All'; // Default to 'All'

  String get selectedType => _selectedType;

  void setType(String type) {
    if (_selectedType != type) {
      _selectedType = type;
      notifyListeners();
    }
  }
}