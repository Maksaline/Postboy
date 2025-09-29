import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyValueRow extends StatelessWidget {
  final TextEditingController keyController;
  final TextEditingController valueController;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final ValueChanged<String> onKeyChanged;
  final ValueChanged<String> onValueChanged;
  final ValueChanged<String> onKeySubmitted;
  final ValueChanged<String> onValueSubmitted;
  final bool enabled;
  final bool advance;
  final String? selectedType;
  final String? selectedOption;
  final int? lower;
  final int? upper;
  final Function(BuildContext)? onOkPressed;
  final ValueChanged<String?>? onTypeChanged;
  final ValueChanged<String?>? onOptionChanged;
  final ValueChanged<String?>? onlowerChanged;
  final ValueChanged<String?>? onUpperChanged;

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
    this.enabled = true,
    this.advance = false,
    this.selectedType = 'Int',
    this.lower = -1,
    this.upper = -1,
    this.onOkPressed,
    this.selectedOption = 'Random',
    this.onTypeChanged,
    this.onOptionChanged,
    this.onlowerChanged,
    this.onUpperChanged,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(right: 8.0),
              child: TextFormField(
                enabled: enabled,
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
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: enabled,
                      controller: valueController,
                      onChanged: onValueChanged,
                      onFieldSubmitted: onValueSubmitted,
                      style: TextStyle(
                        color: valueController.text == '<<<Automation>>>'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Value',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if(advance) IconButton(
                    onPressed: ( ) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Automation Value Input'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 4.0,
                            scrollable: false,
                            content: Container(
                              padding: EdgeInsets.all(16.0),
                              width: 350,
                              child: Table(
                                columnWidths: {
                                  0: IntrinsicColumnWidth(),
                                  1: FlexColumnWidth(),
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Type:', style: Theme.of(context).textTheme.labelLarge),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: DropdownMenu(
                                          dropdownMenuEntries: [
                                            DropdownMenuEntry(value: 'Int', label: 'Int'),
                                            DropdownMenuEntry(value: 'Double', label: 'Double'),
                                            DropdownMenuEntry(value: 'String', label: 'String'),
                                            DropdownMenuEntry(value: 'Bool', label: 'Bool'),
                                          ],
                                          onSelected: onTypeChanged,
                                          initialSelection: selectedType,
                                        )
                                      ),
                                    ]
                                  ),
                                  TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Option:', style: Theme.of(context).textTheme.labelLarge),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: DropdownMenu(
                                              dropdownMenuEntries: [
                                                DropdownMenuEntry(value: 'Random', label: 'Random'),
                                                DropdownMenuEntry(value: 'Incremental', label: 'Incremental'),
                                              ],
                                              onSelected: onOptionChanged,
                                              initialSelection: selectedOption,
                                            )
                                        ),
                                      ]
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('From:', style: Theme.of(context).textTheme.labelLarge),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          onChanged: onlowerChanged,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly, // Only digits 0-9
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller: TextEditingController(text: lower == -1 ? '' : lower.toString()),
                                          decoration: InputDecoration(
                                            hintText: 'Lower Bound',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('To', style: Theme.of(context).textTheme.labelLarge),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          onChanged: onUpperChanged,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly, // Only digits 0-9
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller: TextEditingController(text: upper == -1 ? '' : upper.toString()),
                                          decoration: InputDecoration(
                                            hintText: 'Upper Bound',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel', style: Theme.of(context).textTheme.labelLarge,),
                              ),
                              ElevatedButton(
                                onPressed: () => onOkPressed!(context),
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        }
                      );
                    },
                    icon: Icon(Icons.extension_rounded, size: 24)
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.clear, size: 16),
                    onPressed: (enabled) ? onClear : null,
                    tooltip: 'Clear',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 16),
                    onPressed: (enabled) ? onDelete : null,
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