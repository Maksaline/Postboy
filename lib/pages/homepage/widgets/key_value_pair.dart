import 'package:flutter/material.dart';

class KeyValuePair {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  String selectedType = 'Int';
  String selectedOption = 'Random';
  final TextEditingController lowerController = TextEditingController();
  final TextEditingController upperController = TextEditingController();

  // Optional: Add getters for convenience
  String get key => keyController.text;
  String get value => valueController.text;
  int? get lower => int.tryParse(lowerController.text);
  int? get upper => int.tryParse(upperController.text);
  bool get isRangeValid => lower != null && upper != null && lower! <= upper!;
  String get type => selectedType;
  String get option => selectedOption;

  // Optional: Add methods for common operations
  void clear() {
    keyController.clear();
    valueController.clear();
    lowerController.clear();
    upperController.clear();
  }

  bool get isEmpty => keyController.text.isEmpty && valueController.text.isEmpty;
  bool get isNotEmpty => !isEmpty;

  // Important: Dispose controllers when no longer needed
  void dispose() {
    keyController.dispose();
    valueController.dispose();
    lowerController.dispose();
    upperController.dispose();
  }

  // Optional: Convert to Map for easy serialization
  Map<String, String> toMap() {
    return {
      'key': key,
      'value': value,
    };
  }

  // Optional: Create from Map
  KeyValuePair.fromMap(Map<String, String> map) {
    keyController.text = map['key'] ?? '';
    valueController.text = map['value'] ?? '';
  }

  // Default constructor
  KeyValuePair();
}