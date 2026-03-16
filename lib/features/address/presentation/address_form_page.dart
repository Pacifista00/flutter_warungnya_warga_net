import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';

class AddressFormPage extends StatefulWidget {
  final AddressModel? address;

  const AddressFormPage({super.key, this.address});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = AddressService();

  late TextEditingController recipientController;
  late TextEditingController phoneController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController provinceController;
  late TextEditingController postalController;

  bool isDefault = false;
  bool loading = false;

  bool get isEdit => widget.address != null;

  @override
  void initState() {
    super.initState();

    recipientController = TextEditingController(
      text: widget.address?.recipientName ?? '',
    );

    phoneController = TextEditingController(text: widget.address?.phone ?? '');

    streetController = TextEditingController(
      text: widget.address?.streetAddress ?? '',
    );

    cityController = TextEditingController(text: widget.address?.city ?? '');

    provinceController = TextEditingController(
      text: widget.address?.province ?? '',
    );

    postalController = TextEditingController(
      text: widget.address?.postalCode ?? '',
    );

    isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    recipientController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    provinceController.dispose();
    postalController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    final data = {
      "recipient_name": recipientController.text,
      "phone": phoneController.text,
      "street_address": streetController.text,
      "city": cityController.text,
      "province": provinceController.text,
      "postal_code": postalController.text,
      "is_default": isDefault,
    };

    try {
      if (isEdit) {
        await _service.updateAddress(id: widget.address!.id, data: data);
      } else {
        await _service.createAddress(data);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit
                  ? "Alamat berhasil diperbarui"
                  : "Alamat berhasil ditambahkan",
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

        context.pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 18),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              prefixIcon != null
                  ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Icon(
                      prefixIcon,
                      size: 20,
                      color: Colors.blue.shade700,
                    ),
                  )
                  : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
          ),
        ),
        validator:
            (v) => (v == null || v.isEmpty) ? "$label wajib diisi" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Alamat" : "Tambah Alamat",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("KONTAK PENERIMA"),

                    _buildTextField(
                      label: "Nama Penerima",
                      controller: recipientController,
                      prefixIcon: Icons.person_outline,
                    ),

                    _buildTextField(
                      label: "No Telepon",
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_android_outlined,
                    ),

                    _buildSectionTitle("DETAIL ALAMAT"),

                    _buildTextField(
                      label: "Alamat Jalan / Gedung",
                      controller: streetController,
                      maxLines: 2,
                      prefixIcon: Icons.location_on_outlined,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: "Kota",
                            controller: cityController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            label: "Provinsi",
                            controller: provinceController,
                          ),
                        ),
                      ],
                    ),

                    _buildTextField(
                      label: "Kode Pos",
                      controller: postalController,
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SwitchListTile(
                        value: isDefault,
                        title: const Text(
                          "Jadikan alamat utama",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        secondary: Icon(
                          Icons.star,
                          color: Colors.blue.shade600,
                        ),
                        onChanged: (v) => setState(() => isDefault = v),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: loading ? null : submit,
                  child:
                      loading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            isEdit ? "Simpan Perubahan" : "Tambah Alamat",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
