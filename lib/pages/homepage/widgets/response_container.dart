import 'package:flutter/material.dart';

class ResponseContainer extends StatefulWidget {
  const ResponseContainer({super.key});

  @override
  State<ResponseContainer> createState() => _ResponseContainerState();
}

class _ResponseContainerState extends State<ResponseContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.receipt_long_rounded, color: Theme.of(context).colorScheme.onPrimary),
                  const SizedBox(width: 8.0),
                  Text(
                    'Response',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'View the response from your API request here. This section will display the status code, headers, and body of the response.',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        )
      ],
    );
  }
}
