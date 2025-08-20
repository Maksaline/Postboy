import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/response_cubit.dart';
import '../../../cubits/theme_cubit.dart';

class ResponseContainer extends StatefulWidget {
  const ResponseContainer({super.key});

  @override
  State<ResponseContainer> createState() => _ResponseContainerState();
}

class _ResponseContainerState extends State<ResponseContainer> {

  Color _getStatusColor(int code) {
    if (code >= 200 && code < 300) return ThemeCubit.successGreen;
    if (code >= 300 && code < 400) return ThemeCubit.primaryOrange;
    if (code >= 400) return ThemeCubit.errorRed;
    return Color(0xFF8E8E93);
  }
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
                return loadedResponse(state, context);
              } else if (state is ResponseFailure) {
                return Expanded(child: Center(child: Text('Error: ${state.message}', style: Theme.of(context).textTheme.bodyMedium)));
              }
              return const SizedBox.shrink();
            }
        ),
      ],
    );
  }

  Padding loadedResponse(ResponseLoaded state, BuildContext context) {
    int code = state.statusCode ?? 0;
    Color statusColor = _getStatusColor(code);
    return
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: statusColor,
                          width: 1.0,
                        )
                      ),
                      child: Text(
                        '${state.statusCode} ${state.statusMessage}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outline,
                        // (theme.brightness == Brightness.dark) ? Colors.grey.shade700 : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.timer, size: 16.0),
                          const SizedBox(width: 4.0),
                          Text(
                            '${state.time} ms',
                            style: Theme.of(context).textTheme.titleMedium
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outline,
                        // (theme.brightness == Brightness.dark) ? Colors.grey.shade700 : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.memory, size: 16.0),
                          const SizedBox(width: 4.0),
                          Text(
                              '${state.size}B',
                              style: Theme.of(context).textTheme.titleMedium
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  child: Text(
                    state.body.isEmpty ? 'No body content' : state.body,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  ),
                )
              ],
            );
          }
        )
      );
  }

  Expanded loadingResponse() {
    return
      Expanded(
        child: Center(
          child: CircularProgressIndicator()
        ),
      );
  }

  Expanded initialResponse(BuildContext context) {
    return
      Expanded(
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
