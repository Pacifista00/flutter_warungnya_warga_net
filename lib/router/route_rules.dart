/// Bisa diakses tanpa login
const publicRoutes = <String>[
  '/',
  '/onboarding',
  '/login',
  '/register',
  '/home',
];

/// Butuh login tapi email boleh belum verified
const semiProtectedRoutes = <String>['/verify-email'];

/// WAJIB login + email verified
const protectedRoutes = <String>[
  '/voucher',
  '/profile',
  '/cart',
  '/orders',
  '/produk',
];
