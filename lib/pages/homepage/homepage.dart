import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/builder_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/collection_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/response_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/window_buttons.dart';

import '../../../cubits/theme_cubit.dart';

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
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            child: Icon(
                              Icons.api,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 15,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Postboy',
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 1,
                      ),
                    ),
                  ),
                  child: WindowButtons()
                ),
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
