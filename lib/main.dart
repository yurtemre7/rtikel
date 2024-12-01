import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtikel/providers/progress_provider.dart';
import 'package:rtikel/view/home_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(progressProvider.notifier).loadProgress();
  runApp(
    const ProviderScope(
      overrides: [
        // Überschreiben Sie hier Provider, falls nötig
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ShadApp.material(
      title: 'rtikel',
      home: HomePage(),
      themeMode: ThemeMode.dark,
    );
  }
}
