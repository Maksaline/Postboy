import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_api_tester/cubits/theme_cubit.dart';

class BuilderContainer extends StatefulWidget {
  const BuilderContainer({super.key});

  @override
  State<BuilderContainer> createState() => _BuilderContainerState();
}

class _BuilderContainerState extends State<BuilderContainer> {
  String requestType = 'GET';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 1.0,
          ),
        ),
      ),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.onPrimary,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'New Request',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (theme.brightness == Brightness.dark) ? Theme.of(context).colorScheme.secondary : Colors.grey.shade400,
                        foregroundColor: Theme.of(context).colorScheme.onSecondary,
                      ),
                      onPressed: () {

                      },
                      child: Row(
                        children: [
                          Icon(Icons.save, color: Theme.of(context).colorScheme.onSecondary),
                          SizedBox(width: 8.0),
                          Text('Save', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Theme.of(context).colorScheme.outline,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary,
                            )
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (value) {
                                setState(() {
                                  requestType = value.toString();
                                });
                              },
                              value: requestType,
                              items: const [
                                DropdownMenuItem(value: 'GET', child: Text('GET', style: TextStyle(color: Colors.green))),
                                DropdownMenuItem(value: 'POST', child: Text('POST', style: TextStyle(color: Colors.blue))),
                                DropdownMenuItem(value: 'PUT', child: Text('PUT', style: TextStyle(color: Colors.orange))),
                                DropdownMenuItem(value: 'DELETE', child: Text('DELETE', style: TextStyle(color: Colors.red))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.outline,
                              labelText: 'Enter URL',
                              hintText: 'https://api.example.com/endpoint',
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            // Handle send request action
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9.0),
                            child: Row(
                              children: [
                                Icon(Icons.send, color: Theme.of(context).colorScheme.onSecondary),
                                SizedBox(width: 8.0),
                                Text('Send', style: Theme.of(context).textTheme.labelLarge),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              )
            ],
          );
        }
      ),
    );
  }
}
