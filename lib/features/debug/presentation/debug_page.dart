import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/storage/secure_storage.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  Future<void> _testStorage() async {
    await SecureStorage.saveToken('test-token-123');
    final token = await SecureStorage.getToken();
    debugPrint('TOKEN: $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Storage')),
      body: Center(
        child: ElevatedButton(
          onPressed: _testStorage,
          child: const Text('Test Secure Storage'),
        ),
      ),
    );
  }
}
