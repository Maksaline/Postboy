import 'package:flutter/material.dart';

class EditableTitleWidget extends StatefulWidget {
  final String initialTitle;
  final Function(String)? onTitleChanged;

  const EditableTitleWidget({
    super.key,
    required this.initialTitle,
    this.onTitleChanged,
  });

  @override
  State<EditableTitleWidget> createState() => _EditableTitleWidgetState();
}

class _EditableTitleWidgetState extends State<EditableTitleWidget> {
  bool _isEditing = false;
  late TextEditingController _controller;
  late String _currentTitle;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentTitle = widget.initialTitle;
    _controller = TextEditingController(text: _currentTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
      _controller.text = _currentTitle;
    });
  }

  void _saveTitle() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _currentTitle = _controller.text.trim();
        _isEditing = false;
      });

      // Call the callback function if provided
      if (widget.onTitleChanged != null) {
        widget.onTitleChanged!(_currentTitle);
      }
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _controller.text = _currentTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _startEditing,
              child: _isEditing ? _buildEditingWidget() : _buildDisplayWidget(),
            ),
          ),
          // if (!_isEditing)
          //   IconButton(
          //     icon: const Icon(Icons.edit),
          //     onPressed: _startEditing,
          //   ),
          if (_isEditing) ...[
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: _saveTitle,
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: _cancelEditing,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDisplayWidget() {
    return Text(
      _currentTitle,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildEditingWidget() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        autofocus: true,
        style: Theme.of(context).textTheme.titleLarge,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          fillColor: Theme.of(context).colorScheme.outline,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Title cannot be empty';
          }
          return null;
        },
        onFieldSubmitted: (_) => _saveTitle(),
      ),
    );
  }
}

// Example usage in your main widget
class ExampleUsage extends StatefulWidget {
  @override
  State<ExampleUsage> createState() => _ExampleUsageState();
}

class _ExampleUsageState extends State<ExampleUsage> {
  String currentTitle = "New Request";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editable Title Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EditableTitleWidget(
              initialTitle: currentTitle,
              onTitleChanged: (newTitle) {
                setState(() {
                  currentTitle = newTitle;
                });
                print('Title changed to: $newTitle');
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Current title: $currentTitle',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}