import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/features/address/models/address_model.dart';
import 'package:flutter_warungnya_warga_net/features/address/presentation/address_form_page.dart';
import 'package:flutter_warungnya_warga_net/features/address/presentation/address_list_page.dart';
import 'package:flutter_warungnya_warga_net/features/help/presentation/CaraBelanjaPage.dart';
import 'package:flutter_warungnya_warga_net/features/help/presentation/FaqPage.dart';
import 'package:flutter_warungnya_warga_net/features/help/presentation/InfoMenuPage.dart';
import 'package:flutter_warungnya_warga_net/features/help/presentation/LocationPage.dart';
import 'package:flutter_warungnya_warga_net/features/help/presentation/TermsPage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/core/constant/order_status.dart';
import 'package:flutter_warungnya_warga_net/features/auth/presentation/register.dart';
import 'package:flutter_warungnya_warga_net/features/auth/presentation/verify_email_page.dart';
import 'package:flutter_warungnya_warga_net/features/cart/presentation/cart_page.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/home_page.dart';
import 'package:flutter_warungnya_warga_net/features/order/presentation/order_detail_page.dart';
import 'package:flutter_warungnya_warga_net/features/order/presentation/order_page.dart';
import 'package:flutter_warungnya_warga_net/features/product/presentation/product_detail_page.dart';
import 'package:flutter_warungnya_warga_net/features/product/presentation/product_page.dart';
import 'package:flutter_warungnya_warga_net/features/profile/presentation/profile_page.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/presentation/voucher_detail_page.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/presentation/voucher_page.dart';
import 'package:flutter_warungnya_warga_net/router/route_guard.dart';
import '../features/splash/presentation/splash_page.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import '../features/auth/presentation/login_page.dart';

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
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return VerifyEmailPage(email: email);
        },
      ),

      // PROTECTED (LOGIN REQUIRED)
      GoRoute(path: '/home', builder: (_, __) => const HomePage()),
      GoRoute(
        path: '/produk',
        builder: (context, state) {
          final search = state.uri.queryParameters['search'] ?? '';
          final category = state.uri.queryParameters['category'] ?? '';

          return ProdukPage(initialSearch: search, initialCategory: category);
        },
      ),

      GoRoute(
        path: '/product/:id',
        builder: (_, state) {
          final id = state.pathParameters['id'] ?? '';
          return ProductDetailPage(productId: id);
        },
      ),

      GoRoute(path: '/voucher', builder: (_, __) => const VoucherPage()),
      GoRoute(
        path: '/voucher/:id',
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return VoucherDetailPage(voucherId: id);
        },
      ),

      GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
      GoRoute(path: '/cart', builder: (_, __) => const CartPage()),

      GoRoute(
        path: '/orders/:status',
        name: 'order-list',
        builder: (_, state) {
          final statusParam = state.pathParameters['status']!;
          final status = OrderStatus.values.byName(statusParam);
          return OrderListPage(status: status);
        },
      ),

      GoRoute(
        path: '/help',
        name: 'help',
        builder: (_, __) => const InfoMenuPage(),
      ),
      GoRoute(path: '/faq', name: 'faq', builder: (_, __) => const FaqPage()),
      GoRoute(
        path: '/cara-belanja',
        builder: (context, state) => const CaraBelanjaPage(),
      ),

      GoRoute(path: '/terms', builder: (context, state) => const TermsPage()),
      GoRoute(
        path: '/location',
        builder: (context, state) => const LocationPage(),
      ),

      GoRoute(
        path: '/addresses',
        name: 'address-list',
        builder: (_, __) => const AddressListPage(),
      ),

      GoRoute(
        path: '/addresses/create',
        builder: (context, state) => const AddressFormPage(),
      ),

      GoRoute(
        path: '/addresses/edit',
        builder: (context, state) {
          final address = state.extra as AddressModel;
          return AddressFormPage(address: address);
        },
      ),

      GoRoute(
        path: '/orders/detail/:code',
        name: 'order-detail',
        builder: (_, state) {
          final code = state.pathParameters['code']!;
          return OrderDetailPage(orderCode: code);
        },
      ),
    ],
  );
});
