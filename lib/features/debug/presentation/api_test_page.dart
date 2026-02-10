import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class ApiTestPage extends StatefulWidget {
  const ApiTestPage({super.key});

  @override
  State<ApiTestPage> createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  String result = 'Belum test';

  Future<void> testProducts() async {
    try {
      final dio = DioClient.create();
      final response = await dio.get('/api/products');

      setState(() {
        result =
            'SUCCESS\nStatus: ${response.statusCode}\n'
            'Data: ${response.data.toString()}';
      });
    } on DioException catch (e) {
      setState(() {
        result =
            'ERROR\n'
            'Status: ${e.response?.statusCode}\n'
            'Message: ${e.message}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    testProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API TEST')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(result)),
      ),
    );
  }
}
