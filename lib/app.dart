import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_theme.dart';
import 'package:flutter_warungnya_warga_net/router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Online Shop',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}
