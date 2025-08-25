import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_api_tester/cubits/response_cubit.dart';
import 'package:minimalist_api_tester/cubits/theme_cubit.dart';
import 'package:minimalist_api_tester/pages/homepage/homepage.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: 'Postboy Desktop',
    size: Size(1920, 1080), // Set your preferred size
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle('Postboy Desktop');
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });
  
  runApp(BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ResponseCubit()),
          ],
          child: MaterialApp(
            title: 'Postboy Pro',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const Homepage(),
          ),
        );
      }
    );
  }
}
