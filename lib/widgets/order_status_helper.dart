import 'package:flutter/material.dart';

class OrderStatusHelper {
  static String message(String status) {
    switch (status.toLowerCase()) {
      /// PAYMENT
      case "paid":
        return "Pembayaran telah diterima. Pesanan Anda sedang kami proses.";

      case "pending":
        return "Menunggu pembayaran Anda.";

      case "expired":
        return "Pembayaran telah kadaluarsa.";

      /// ORDER
      case "created":
        return "Pesanan telah dibuat dan menunggu pembayaran.";

      case "processing":
        return "Pesanan sedang diproses oleh penjual.";

      case "packed":
        return "Pesanan telah dikemas dan siap dikirim.";

      case "completed":
        return "Pesanan telah selesai.";

      case "cancelled":
        return "Pesanan telah dibatalkan.";

      case "returned":
        return "Pesanan telah dikembalikan.";

      case "disposed":
        return "Pesanan telah dimusnahkan.";

      /// SHIPPING
      case "allocated":
        return "Kurir telah ditugaskan untuk mengambil paket.";

      case "picking_up":
        return "Kurir sedang menuju lokasi pengambilan paket.";

      case "picked":
        return "Paket telah diambil oleh kurir.";

      case "dropping_off":
        return "Paket sedang dalam perjalanan ke alamat tujuan.";

      case "on_hold":
        return "Pengiriman sedang tertahan.";

      case "delivered":
        return "Paket telah berhasil dikirim.";

      case "return_in_transit":
        return "Paket sedang dalam proses pengembalian.";

      case "courier_not_found":
        return "Kurir tidak ditemukan untuk pengiriman ini.";

      default:
        return "Status pesanan tidak diketahui.";
    }
  }

  static Color color(String status) {
    switch (status.toLowerCase()) {
      case "paid":
      case "completed":
      case "delivered":
        return Colors.green;

      case "pending":
      case "created":
        return Colors.orange;

      case "processing":
      case "packed":
      case "allocated":
        return Colors.blue;

      case "picking_up":
      case "picked":
      case "dropping_off":
        return Colors.purple;

      case "on_hold":
        return Colors.orange;

      case "expired":
      case "cancelled":
      case "returned":
      case "disposed":
      case "return_in_transit":
      case "courier_not_found":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }
}
