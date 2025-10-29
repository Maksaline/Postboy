import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_api_tester/cubits/collection_cubit.dart';
import 'package:minimalist_api_tester/cubits/response_cubit.dart';
import 'package:minimalist_api_tester/cubits/theme_cubit.dart';
import 'package:minimalist_api_tester/pages/homepage/homepage.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: 'Postboy',
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle('Postboy');
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });
  
  runApp(BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp()
    )
  );

  doWhenWindowReady(() {
    const initialSize = Size(1310, 700);
    appWindow.minSize = initialSize;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ResponseCubit()),
            BlocProvider(create: (context) => CollectionCubit()),
          ],
          child: MaterialApp(
            title: 'Postboy',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const Homepage(),
          ),
        );
      }
    );
  }
}
