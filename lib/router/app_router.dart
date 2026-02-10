import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/home_page.dart';
import 'package:flutter_warungnya_warga_net/features/onboarding/presentation/onboarding_page.dart';
import 'package:flutter_warungnya_warga_net/features/presentation/splash_page.dart';
import 'package:flutter_warungnya_warga_net/router/route_guard.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      return routeGuard(ref, state.uri.toString());
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashPage()),

      // PUBLIC
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),
      GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    ],
  );
});
