import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/address/widgets/address_card.dart';
import 'package:go_router/go_router.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  final AddressService _service = AddressService();

  late Future<List<AddressModel>> _futureAddresses;

  bool deleting = false;

  @override
  void initState() {
    super.initState();
    _futureAddresses = _service.getAddresses();
  }

  Future<void> refreshAddresses() async {
    setState(() {
      _futureAddresses = _service.getAddresses();
    });

    await _futureAddresses;
  }

  Future<void> handleDelete(AddressModel address) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Alamat"),
          content: const Text("Apakah Anda yakin ingin menghapus alamat ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      setState(() {
        deleting = true;
      });

      await _service.deleteAddress(address.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Alamat berhasil dihapus"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      await refreshAddresses();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          deleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Alamat")),

      body: FutureBuilder<List<AddressModel>>(
        future: _futureAddresses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final addresses = snapshot.data ?? [];

          if (addresses.isEmpty) {
            return const Center(child: Text("Belum ada alamat"));
          }

          return RefreshIndicator(
            onRefresh: refreshAddresses,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];

                return AddressCard(
                  address: address,

                  onEdit: () async {
                    final result = await context.push(
                      '/addresses/edit',
                      extra: address,
                    );

                    if (result == true) {
                      refreshAddresses();
                    }
                  },

                  onDelete:
                      deleting
                          ? null
                          : () {
                            handleDelete(address);
                          },
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/addresses/create');

          if (result == true) {
            refreshAddresses();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
