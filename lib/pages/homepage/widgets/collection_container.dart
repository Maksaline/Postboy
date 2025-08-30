import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/theme_cubit.dart';

class CollectionContainer extends StatefulWidget {
  const CollectionContainer({super.key});

  @override
  State<CollectionContainer> createState() => _CollectionContainerState();
}

class _CollectionContainerState extends State<CollectionContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.onPrimary,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          Icons.api,
                          color: theme.colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Text('Postboy', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32),)
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Manage your API collections and requests with ease.',
                    style: Theme.of(context).textTheme.bodyMedium)
                ],
              )
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.folder, color: theme.colorScheme.onPrimary),
                  SizedBox(width: 8.0),
                  Text('Collections', style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.add, color: theme.colorScheme.primary),
                    onPressed: () {
                      // Handle add collection action
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: theme.colorScheme.onPrimary,
                          width: 1.0,
                        ),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: 1, // Example item count
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text('GET', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green),),
                            SizedBox(width: 16.0),
                            Text('New Request'),
                          ],
                        ),
                        onTap: () {
                          // Handle collection tap
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.onPrimary,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark Mode', style: Theme.of(context).textTheme.titleMedium),
                      Switch(
                        value: theme.brightness == Brightness.dark,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        activeColor: theme.colorScheme.primary,
                        inactiveTrackColor: theme.colorScheme.onPrimary
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Version 0.1.0', style: Theme.of(context).textTheme.bodySmall),
                      Text(
                        '© 2025 Postboy',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
