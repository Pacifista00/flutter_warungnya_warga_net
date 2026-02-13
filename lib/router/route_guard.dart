import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/provider/last_route_provider.dart';
import '../features/auth/auth_provider.dart';
import '../features/auth/domain/auth_state.dart';
import '../features/onboarding/presentation/onboarding_controller.dart';
import 'route_rules.dart';

String? routeGuard(Ref ref, String location) {
  final hasOnboarded = ref.read(onboardingProvider);
  final authState = ref.read(authProvider);

  // 0️⃣ onboarding belum load
  if (hasOnboarded == null) return null;

  // 1️⃣ auth belum siap
  if (authState.status == AuthStatus.unknown) return null;

  // 2️⃣ onboarding dulu
  if (hasOnboarded == false && location != '/onboarding') {
    return '/onboarding';
  }

  // 3️⃣ route PUBLIC → bebas
  if (publicRoutes.contains(location)) {
    if (authState.status == AuthStatus.unauthenticated) {
      ref.read(lastRouteProvider.notifier).state = location;
    }
    return null;
  }

  // 4️⃣ route PROTECTED
  final isProtected = protectedRoutes.any(
    (route) => location.startsWith(route),
  );

  if (isProtected) {
    if (authState.status == AuthStatus.unauthenticated) {
      return '/login?from=$location';
    }

    if (authState.status == AuthStatus.emailNotVerified) {
      return '/verify-email';
    }
  }

  // 5️⃣ sudah login tapi masih di login/register
  if (authState.status == AuthStatus.authenticated &&
      (location == '/login' || location == '/register')) {
    return '/home';
  }

  return null;
}
