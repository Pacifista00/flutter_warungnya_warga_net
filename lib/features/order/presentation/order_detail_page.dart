import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/midtrans_payment_page.dart';
import 'package:flutter_warungnya_warga_net/widgets/format_date_time.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';
import 'package:flutter_warungnya_warga_net/widgets/order_status_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

import '../widgets/info_box.dart';
import '../widgets/key_value_row.dart';
import '../widgets/product_item.dart';
import '../widgets/section_header.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderCode;

  const OrderDetailPage({super.key, required this.orderCode});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;
  late Future<OrderModel> futureOrder;
  bool cancelLoading = false;

  @override
  void initState() {
    super.initState();
    futureOrder = OrderService().getOrder(widget.orderCode);
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown(String expiredAt) {
    final expiry = DateTime.parse(expiredAt).toLocal();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final diff = expiry.difference(DateTime.now());

      if (diff.isNegative) {
        timer.cancel();
        setState(() {
          remainingTime = Duration.zero;
        });
      } else {
        setState(() {
          remainingTime = diff;
        });
      }
    });
  }

  Future<void> _handlePayNow(OrderModel order) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final response = await OrderService().retryPayment(order.id.toString());

      if (!mounted) return;
      Navigator.pop(context); // tutup loading

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => MidtransPaymentPage(
                snapToken: response["snapToken"],
                orderId: order.id, // dari object
                orderNumber: order.orderNumber, // dari object
              ),
        ),
      );
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal membuka pembayaran: $e")));
    }
  }

  Future<void> _handleCancelOrder(OrderModel order) async {
    setState(() => cancelLoading = true);

    try {
      await OrderService().cancelOrder(order.id.toString());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pesanan berhasil dibatalkan")),
      );

      // refresh data
      setState(() {
        futureOrder = OrderService().getOrder(widget.orderCode);
        countdownTimer?.cancel();
        countdownTimer = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal membatalkan pesanan: $e")));
    } finally {
      if (mounted) {
        setState(() => cancelLoading = false);
      }
    }
  }

  Future<void> _confirmCancel(OrderModel order) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Batalkan Pesanan"),
          content: const Text(
            "Yakin ingin membatalkan pesanan ini?\nTindakan ini tidak bisa dibatalkan.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Ya, Batalkan",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      _handleCancelOrder(order);
    }
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  String formatCurrency(int value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  Widget _paymentStamp(String status) {
    String text;
    Color color;

    switch (status) {
      case "paid":
        text = "LUNAS";
        color = Colors.green;
        break;
      case "pending":
        text = "PENDING";
        color = Colors.orange;
        break;
      case "unpaid":
        text = "BELUM BAYAR";
        color = Colors.red;
        break;
      case "expired":
        text = "KADALUARSA";
        color = Colors.grey;
        break;
      default:
        text = status.toUpperCase();
        color = Colors.blueGrey;
    }

    return IgnorePointer(
      child: Opacity(
        opacity: 0.15, // transparan
        child: Transform.rotate(
          angle: -0.3, // miring
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 3),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/profile");
          },
        ),
      ),
      body: FutureBuilder<OrderModel>(
        future: futureOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // if (snapshot.hasError) {
          //   return const Center(child: Text("Gagal memuat pesanan"));
          // }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat pesanan:\n${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final order = snapshot.data!;
          bool canCancel =
              ["created", "pending", "processing"].contains(order.status) &&
              [
                "unpaid",
                "pending",
                "paid",
                "expired",
              ].contains(order.paymentStatus) &&
              order.shippingStatus.isEmpty;
          if (order.expiredAt.isNotEmpty &&
              order.paymentStatus == "unpaid" &&
              countdownTimer == null) {
            startCountdown(order.expiredAt);
          }
          String displayStatus;

          if (order.paymentStatus == "expired" &&
              order.expiredAt.isNotEmpty &&
              DateTime.parse(
                order.expiredAt,
              ).toLocal().isBefore(DateTime.now())) {
            displayStatus = "expired";
          } else {
            displayStatus =
                order.shippingStatus.isNotEmpty
                    ? order.shippingStatus
                    : order.status;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Text(
                  'Order #${order.orderNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dibuat pada ${order.createdAtFormatted}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 16),
                if (order.expiredAt.isNotEmpty &&
                    order.paymentStatus == "unpaid") ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Pesanan akan kedaluwarsa pada ${formatDateTime(order.expiredAt)}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text(
                              "Sisa waktu pembayaran: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              formatDuration(remainingTime),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],

                /// INFO BOX
                InfoBox(
                  icon: Icons.info,
                  color: OrderStatusHelper.color(displayStatus),
                  text: OrderStatusHelper.message(displayStatus),
                ),

                const SizedBox(height: 24),

                /// SHIPPING
                const SectionHeader(title: 'Informasi Pengiriman'),

                const SizedBox(height: 12),

                if (order.trackingNumber.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        const Text(
                          'Resi',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),

                        const Spacer(),

                        Text(order.trackingNumber),

                        const SizedBox(width: 6),

                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: order.trackingNumber),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Resi berhasil disalin"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Icon(Icons.copy, size: 14),
                        ),
                      ],
                    ),
                  ),
                KeyValueRow(
                  label: 'Kurir',
                  value:
                      '${order.courier.code.toUpperCase()} - ${order.courier.service}',
                ),

                KeyValueRow(
                  label: 'Biaya Pengiriman',
                  value: formatCurrency(order.shippingCost),
                ),

                const SizedBox(height: 24),

                /// PRODUCT
                const SectionHeader(title: 'Daftar Produk'),

                const SizedBox(height: 12),

                Column(
                  children:
                      order.items.map((item) {
                        return ProductItem(
                          name: item.productName,
                          imageUrl: item.imageUrl,
                          quantity: item.quantity,
                          price: item.unitPrice,
                        );
                      }).toList(),
                ),

                const SizedBox(height: 24),

                /// PAYMENT SUMMARY
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(title: 'Ringkasan Pembayaran'),
                        const SizedBox(height: 12),

                        KeyValueRow(
                          label: 'Subtotal Produk',
                          value: formatCurrency(order.subtotal),
                        ),

                        KeyValueRow(
                          label: 'Ongkos Kirim',
                          value: formatCurrency(order.shippingCost),
                        ),

                        if (order.voucherDiscount > 0)
                          KeyValueRow(
                            label: 'Diskon Voucher',
                            value: "- ${formatCurrency(order.voucherDiscount)}",
                          ),

                        if (order.pointsDiscount > 0)
                          KeyValueRow(
                            label: 'Diskon Poin',
                            value: "- ${formatCurrency(order.pointsDiscount)}",
                          ),

                        const Divider(height: 16),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                formatCurrency(order.totalAmount),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// STAMP OVERLAY
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: _paymentStamp(order.paymentStatus),
                      ),
                    ),
                  ],
                ),
                if (canCancel) ...[
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppButton(
                      text:
                          cancelLoading ? "Membatalkan..." : "Batalkan Pesanan",
                      onPressed:
                          cancelLoading ? null : () => _confirmCancel(order),
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                ],
                if ((order.paymentStatus == "unpaid" ||
                        order.paymentStatus == "pending") &&
                    displayStatus != "expired") ...[
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppButton(
                      text: "Bayar Sekarang",
                      onPressed: () => _handlePayNow(order),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
