import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_warungnya_warga_net/features/order/services/order_service.dart';
import 'package:flutter_warungnya_warga_net/features/payment/payment_success_page.dart';

class MidtransPaymentPage extends StatefulWidget {
  final String snapToken;
  final String orderId;
  final String orderNumber;

  const MidtransPaymentPage({
    super.key,
    required this.snapToken,
    required this.orderId,
    required this.orderNumber,
  });

  @override
  State<MidtransPaymentPage> createState() => _MidtransPaymentPageState();
}

class _MidtransPaymentPageState extends State<MidtransPaymentPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) {
                // jika redirect ke after-payment
                if (request.url.contains("after-payment")) {
                  checkPaymentStatus();

                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              "https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}",
            ),
          );
  }

  Future<void> checkPaymentStatus() async {
    final order = await OrderService().getOrder(widget.orderId);

    if (!mounted) return;

    final status = order.paymentStatus;

    if (status == "paid") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentSuccessPage(orderId: widget.orderId),
        ),
      );
    } else if (status == "pending") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pembayaran masih menunggu")),
      );
    } else if (status == "expired") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pembayaran kadaluarsa")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pembayaran")),
      body: WebViewWidget(controller: controller),
    );
  }
}
