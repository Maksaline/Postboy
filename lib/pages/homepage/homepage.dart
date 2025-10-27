import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/builder_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/collection_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/response_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/window_buttons.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                  child: MoveWindow(
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                WindowButtons(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: CollectionContainer()
                ),
                Flexible(
                  flex: 7,
                  child: BuilderContainer(),
                ),
                Flexible(
                  flex: 3,
                  child: ResponseContainer()
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
