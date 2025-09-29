import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_api_tester/cubits/collection_cubit.dart';
import 'package:minimalist_api_tester/models/collection.dart';

import '../../../cubits/theme_cubit.dart';

class CollectionContainer extends StatefulWidget {
  const CollectionContainer({super.key});

  @override
  State<CollectionContainer> createState() => _CollectionContainerState();
}

class _CollectionContainerState extends State<CollectionContainer> {

  @override
  void initState() {
    super.initState();
    context.read<CollectionCubit>().addNewCollection();
    context.read<CollectionCubit>().fetchSavedRequests();
  }
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
                  Expanded(
                      child: Text(
                          'Requests',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1
                      )
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: theme.colorScheme.primary),
                    onPressed: () {
                      context.read<CollectionCubit>().addNewCollection();
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
                  child: BlocBuilder<CollectionCubit, CollectionState>(
                    builder: (context, state) {
                      if (state is CollectionLoaded) {
                        List<Collection> collections = state.collections;
                        if (collections.isEmpty) {
                          return Center(
                            child: Text('Please add a Request', style: Theme.of(context).textTheme.bodyMedium),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListView.builder(
                            itemCount: collections.length,
                            itemBuilder: (context, index) {
                              Color methodColor;
                              switch (collections[index].method) {
                                case 'GET':
                                  methodColor = Colors.green;
                                  break;
                                case 'POST':
                                  methodColor = Colors.blue;
                                  break;
                                case 'PUT':
                                  methodColor = Colors.orange;
                                  break;
                                case 'DELETE':
                                  methodColor = Colors.red;
                                  break;
                                case 'PATCH':
                                  methodColor = Colors.purple;
                                  break;
                                case 'HEAD':
                                  methodColor = Colors.brown;
                                  break;
                                case 'OPTIONS':
                                  methodColor = Colors.grey;
                                  break;
                                default:
                                  methodColor = Colors.black;
                              }
                              return ListTile(
                                contentPadding: EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0, right: 0.0),
                                selectedTileColor: Theme.of(context).colorScheme.primary.withAlpha(50),
                                selectedColor: Theme.of(context).colorScheme.onSecondary,
                                selected: state.index == index,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      child: Text(collections[index].method, style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: methodColor),),
                                    ),
                                    Expanded(
                                      child: Text(
                                          collections[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  context.read<CollectionCubit>().updateIndex(index);
                                },
                                trailing: PopupMenuButton(
                                  tooltip: 'Actions',
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 8.0),
                                          Text('Delete'),
                                        ],
                                      ),
                                      onTap: () {
                                        context.read<CollectionCubit>().deleteCollection(index);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('No Collection Found', style: Theme.of(context).textTheme.bodyMedium),
                        );
                      }
                    }
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
