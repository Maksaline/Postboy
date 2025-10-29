import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/builder_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/collection_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/response_container.dart';
import 'package:minimalist_api_tester/pages/homepage/widgets/window_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
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
                          SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: _toggleMenu,
                                  icon: AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: _controller,
                                    color: Theme.of(context).colorScheme.onSecondary,
                                  ),
                                  iconSize: 16,
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: SizedBox(
                                    width: _isExpanded ? null : 0,
                                    child: AnimatedOpacity(
                                      opacity: _isExpanded ? 1.0 : 0.0,
                                      duration: const Duration(milliseconds: 200),
                                      child: TextButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://github.com/Maksaline/Postboy');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                          throw Exception('Could not launch $url');
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context).colorScheme.onSecondary,
                                          shape : RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0.0),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'C',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'ontribute',
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
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
                          const Spacer(),
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
