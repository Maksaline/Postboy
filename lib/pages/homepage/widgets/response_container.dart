import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/response_cubit.dart';

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
              ),
            ],
          )
        ),
        BlocBuilder<ResponseCubit, ResponseState>(
            builder: (context, state) {
              if( state is ResponseInitial) {
                return initialResponse(context);
              } else
              if (state is ResponseLoading) {
                return loadingResponse();
              } else if (state is ResponseLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status Code: ${state.statusCode}', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8.0),
                    Text('Headers: ${state.headers}', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8.0),
                    Text('Body: ${state.body}', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8.0),
                    Text('Time taken: ${state.time} ms', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8.0),
                    Text('Size: ${state.size} bytes', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                );
              } else if (state is ResponseFailure) {
                return Text('Error: ${state.message}', style: Theme.of(context).textTheme.bodyMedium);
              }
              return const SizedBox.shrink();
            }
        ),
      ],
    );
  }

  Expanded loadingResponse() {
    return Expanded(
                child: Center(
                    child: CircularProgressIndicator()
                ),
              );
  }

  Expanded initialResponse(BuildContext context) {
    return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Theme.of(context).colorScheme.onPrimary, size: 64.0),
                    const SizedBox(height: 16.0),
                    Text(
                      'No response yet',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Send a request to see the response here.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
  }
}
