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
  int tabIndex = 0;
  final tabs = ['Header', 'Body', 'Params', 'Authentication'];
  @override
  Widget build(BuildContext context) {
    return Container(
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
          return SizedBox(
            child: Column(
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
                      const SizedBox(width: 8,),
                      IconButton(
                        onPressed: () {
                          // Handle new request action
                        },
                        icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary),
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
                Expanded(
                  child: Padding(
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
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.outline,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: tabs.map((tab) => Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    tabIndex = tabs.indexOf(tab);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: tabIndex == tabs.indexOf(tab) ? Theme.of(context).colorScheme.surface : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      tab,
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                            )).toList(),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: Column(
                            children: [
                              Flexible(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).colorScheme.outline,
                                        blurRadius: 2.0,
                                        spreadRadius: 3.0,
                                      ),
                                    ],
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                  child: tabIndex == 0 ? const Text('Header Content') :
                                    tabIndex == 1 ? const Text('Body Content') :
                                    tabIndex == 2 ? const Text('Params Content') :
                                    const Text('Authentication Content')
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  height: double.infinity,
                                  margin: EdgeInsets.only(top: 16.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).colorScheme.outline,
                                        blurRadius: 2.0,
                                        spreadRadius: 3.0,
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                  child: const Text('Response will be displayed here'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
