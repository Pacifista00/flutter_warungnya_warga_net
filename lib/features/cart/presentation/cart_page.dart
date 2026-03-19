import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_warungnya_warga_net/features/auth/auth_provider.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_state.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/point_section.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/order_summary.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/cart_item_card.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/footer_checkout.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/empty_cart.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/address/services/address_service.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/cart_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import 'package:flutter_warungnya_warga_net/features/address/models/address_model.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  late Future<List<dynamic>> _combinedDataFuture;
  final CartService _cartService = CartService();
  final AddressService _addressService = AddressService();

  int shippingCost = 0;
  int discount = 0;
  String? voucherCode;
  ShippingModel? selectedShipping;

  final ValueNotifier<int> pointsUsedNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    _combinedDataFuture = Future.wait([
      _cartService.getCart(),
      _checkUserAddressStatus(),
    ]);
  }

  Future<Map<String, bool>> _checkUserAddressStatus() async {
    final List<AddressModel> addresses = await _addressService.getAddresses();
    if (addresses.isEmpty) return {"hasAddress": false, "hasDefault": false};
    final hasDefault = addresses.any((a) => a.isDefault == true);
    return {"hasAddress": true, "hasDefault": hasDefault};
  }

  void refreshCart() {
    setState(() {
      _initData();
    });
  }

  @override
  void dispose() {
    pointsUsedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final userPoints =
        authState.status == AuthStatus.authenticated && user != null
            ? (user['point']?['total_points'] ?? 0)
            : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _combinedDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat data'));
          }

          final cart = snapshot.data![0] as CartModel;
          final addressStatus = snapshot.data![1] as Map<String, bool>;

          if (!addressStatus["hasAddress"]! || !addressStatus["hasDefault"]!) {
            return _buildAddressError(addressStatus["hasAddress"]!);
          }

          if (cart.items.isEmpty) return const EmptyCartWidget();

          final subtotal = cart.items.fold(
            0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...cart.items.map(
                      (item) => CartItemCard(item: item, onUpdate: refreshCart),
                    ),

                    ValueListenableBuilder<int>(
                      valueListenable: pointsUsedNotifier,
                      builder: (_, pointsUsed, __) {
                        final pointsDiscount = min(pointsUsed * 5000, subtotal);

                        return OrderSummaryCard(
                          cartItems: cart.items,
                          shippingCost: shippingCost,
                          discount: discount,
                          pointsDiscount: pointsDiscount,
                          onShippingChanged: (shipping) {
                            setState(() {
                              selectedShipping = shipping;
                              shippingCost = shipping.price;
                            });
                          },
                          onVoucherApplied: (disc, code) {
                            setState(() {
                              discount = disc;
                              voucherCode = code;

                              // 🔥 RESET POINTS kalau voucher berubah
                              pointsUsedNotifier.value = 0;
                            });
                          },
                        );
                      },
                    ),

                    /// ✅ FIX: pakai subtotal setelah voucher
                    Builder(
                      builder: (_) {
                        final subtotalAfterVoucher = max(
                          0,
                          subtotal - discount,
                        );

                        return PointsSection(
                          userPoints: userPoints,
                          subtotal: subtotalAfterVoucher,
                          valueNotifier: pointsUsedNotifier,
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// FOOTER
              ValueListenableBuilder<int>(
                valueListenable: pointsUsedNotifier,
                builder: (_, pointsUsed, __) {
                  final pointsValue = pointsUsed * 5000;

                  /// ✅ URUTAN BENAR
                  final afterVoucher = max(0, subtotal - discount);
                  final afterPoints = max(0, afterVoucher - pointsValue);

                  final totalFinal = afterPoints + shippingCost;

                  return CartFooter(
                    total: totalFinal,
                    shipping: selectedShipping,
                    voucherCode: voucherCode,
                    pointsUsed: pointsUsed,
                    pointValue: 5000,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddressError(bool hasAddress) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasAddress
                  ? Icons.location_on_outlined
                  : Icons.location_off_outlined,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              hasAddress
                  ? "Alamat utama belum ditentukan"
                  : "Alamat belum ditambahkan",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/addresses'),
              child: const Text("Atur alamat"),
            ),
          ],
        ),
      ),
    );
  }
}
