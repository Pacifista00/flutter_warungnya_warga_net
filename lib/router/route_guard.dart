import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/provider/last_route_provider.dart';
import '../features/auth/auth_provider.dart';
import '../features/auth/domain/auth_state.dart';
import '../features/onboarding/presentation/onboarding_controller.dart';
import 'route_rules.dart';

String? routeGuard(Ref ref, String location) {
  final hasOnboarded = ref.read(onboardingProvider);
  final authStatus = ref.read(authProvider);

  // 0️⃣ auth belum siap
  if (authStatus == AuthStatus.unknown) return null;

  // 1️⃣ onboarding dulu
  if (!hasOnboarded && location != '/onboarding') {
    return '/onboarding';
  }

  // 2️⃣ route PUBLIC → bebas
  if (publicRoutes.contains(location)) {
    if (authStatus == AuthStatus.unauthenticated) {
      ref.read(lastRouteProvider.notifier).state = location;
    }
    return null;
  }

  // 3️⃣ route PROTECTED
  final isProtected = protectedRoutes.any(
    (route) => location.startsWith(route),
  );

  if (isProtected) {
    // belum login
    if (authStatus == AuthStatus.unauthenticated) {
      return '/login?from=$location';
    }

    // login tapi email belum verified
    if (authStatus == AuthStatus.emailNotVerified) {
      return '/verify-email';
    }
  }

  // 4️⃣ sudah login tapi masih di login/register
  if (authStatus == AuthStatus.authenticated &&
      (location == '/login' || location == '/register')) {
    return '/home';
  }

  return null;
}
