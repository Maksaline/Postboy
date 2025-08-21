import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final TextEditingController keyController;
  final TextEditingController valueController;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final ValueChanged<String> onKeyChanged;
  final ValueChanged<String> onValueChanged;
  final ValueChanged<String> onKeySubmitted;
  final ValueChanged<String> onValueSubmitted;

  const KeyValueRow({
    super.key,
    required this.keyController,
    required this.valueController,
    required this.onClear,
    required this.onDelete,
    required this.onKeyChanged,
    required this.onValueChanged,
    required this.onKeySubmitted,
    required this.onValueSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(right: 8.0),
              child: TextFormField(
                controller: keyController,
                onChanged: onKeyChanged,
                onFieldSubmitted: onKeySubmitted,
                decoration: InputDecoration(
                  hintText: 'Key',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(right: 8.0),
              child: TextFormField(
                controller: valueController,
                onChanged: onValueChanged,
                onFieldSubmitted: onValueSubmitted,
                decoration: InputDecoration(
                  hintText: 'Value',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.clear, size: 16),
                    onPressed: onClear,
                    tooltip: 'Clear',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 16),
                    onPressed: onDelete,
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}