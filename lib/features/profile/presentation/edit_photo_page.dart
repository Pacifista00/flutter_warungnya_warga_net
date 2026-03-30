import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/config/env/prod_env.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/auth/auth_provider.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_exceptions.dart';
import 'package:image_picker/image_picker.dart';

class EditPhotoPage extends ConsumerStatefulWidget {
  const EditPhotoPage({super.key});

  @override
  ConsumerState<EditPhotoPage> createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends ConsumerState<EditPhotoPage> {
  File? _selectedImage;
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();

  Future<File?> compressImage(File file) async {
    final String targetPath =
        '${file.parent.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // result is an XFile?
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 70,
      minWidth: 800,
      minHeight: 800,
      format: CompressFormat.jpeg,
    );

    // Convert XFile? to File?
    return result != null ? File(result.path) : null;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // kompres awal
    );

    if (pickedFile != null) {
      File originalFile = File(pickedFile.path);

      // compress
      File? compressedFile = await compressImage(originalFile);
      File finalFile = compressedFile ?? originalFile;

      final sizeInMb = finalFile.lengthSync() / (1024 * 1024);
      if (sizeInMb > 2) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("File terlalu besar. Maksimal 2 MB"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return; // batalkan
      }

      setState(() => _selectedImage = finalFile);
    }
  }

  Future<void> _uploadPhoto() async {
    if (_selectedImage == null) return;

    setState(() => _loading = true);

    try {
      await ref.read(authProvider.notifier).updatePhoto(_selectedImage!.path);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Foto profil berhasil diperbarui"),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } on AuthException catch (e) {
      // tampilkan pesan dari AuthException
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memperbarui foto: ${e.message}"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memperbarui foto: $e"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    final photoUrl =
        user != null && user['photo'] != null
            ? "${ProdEnv.storageUrl}/${user['photo']}"
            : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Foto Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// PREVIEW FOTO
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                backgroundImage:
                    _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : (photoUrl != null ? NetworkImage(photoUrl) : null)
                            as ImageProvider<Object>?,
                child:
                    _selectedImage == null && photoUrl == null
                        ? const Icon(Icons.person, size: 60, color: Colors.grey)
                        : null,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Ketuk foto untuk memilih gambar baru",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const Spacer(),

            /// BUTTON SIMPAN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _loading ? null : _uploadPhoto,
                child:
                    _loading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text(
                          "Simpan Foto",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
