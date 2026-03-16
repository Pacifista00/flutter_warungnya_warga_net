import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/address/services/address_service.dart';

import 'package:flutter_warungnya_warga_net/features/cart/widgets/cart_item_card.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/empty_cart.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/footer_checkout.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/order_summary.dart';

import 'package:flutter_warungnya_warga_net/features/cart/models/cart_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import 'package:flutter_warungnya_warga_net/features/address/models/address_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<CartModel> cartFuture;
  late Future<Map<String, bool>> addressStatusFuture;

  final CartService _cartService = CartService();
  final AddressService _addressService = AddressService();

  int shippingCost = 0;
  int discount = 0;
  String? voucherCode;
  ShippingModel? selectedShipping;

  @override
  void initState() {
    super.initState();
    cartFuture = _cartService.getCart();
    addressStatusFuture = checkUserAddressStatus();
  }

  /// cek status alamat user
  Future<Map<String, bool>> checkUserAddressStatus() async {
    final List<AddressModel> addresses = await _addressService.getAddresses();

    if (addresses.isEmpty) {
      return {"hasAddress": false, "hasDefault": false};
    }

    final hasDefault = addresses.any((a) => a.isDefault == true);

    return {"hasAddress": true, "hasDefault": hasDefault};
  }

  void refreshCart() {
    setState(() {
      cartFuture = _cartService.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Future.wait([cartFuture, addressStatusFuture]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat data'));
          }

          final cart = snapshot.data![0] as CartModel;
          final addressStatus = snapshot.data![1] as Map<String, bool>;

          final hasAddress = addressStatus["hasAddress"]!;
          final hasDefault = addressStatus["hasDefault"]!;

          /// =============================
          /// CASE 1 - BELUM ADA ALAMAT
          /// =============================
          if (!hasAddress) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Alamat belum ditambahkan. Silakan tambahkan alamat terlebih dahulu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/addresses');
                      },
                      child: const Text("Atur alamat pengiriman"),
                    ),
                  ],
                ),
              ),
            );
          }

          /// =====================================
          /// CASE 2 - ADA ALAMAT TAPI BELUM DEFAULT
          /// =====================================
          if (!hasDefault) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 64,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Alamat utama belum ditentukan. Silakan pilih salah satu alamat sebagai alamat utama.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/addresses');
                      },
                      child: const Text("Atur alamat pengiriman"),
                    ),
                  ],
                ),
              ),
            );
          }

          /// =============================
          /// CASE 3 - KERANJANG KOSONG
          /// =============================
          if (cart.items.isEmpty) {
            return const EmptyCartWidget();
          }

          final subtotal = cart.items.fold(
            0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          final total = subtotal + shippingCost - discount;

          /// =============================
          /// CART NORMAL
          /// =============================
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...cart.items.map(
                      (item) => CartItemCard(item: item, onUpdate: refreshCart),
                    ),

                    OrderSummaryCard(
                      cartItems: cart.items,
                      shippingCost: shippingCost,
                      discount: discount,
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
                        });
                      },
                    ),
                  ],
                ),
              ),

              CartFooter(
                total: total,
                shipping: selectedShipping,
                voucherCode: voucherCode,
              ),
            ],
          );
        },
      ),
    );
  }
}
