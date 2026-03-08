import 'package:flutter/material.dart';

class VoucherDetailSkeleton extends StatelessWidget {
  const VoucherDetailSkeleton({super.key});

  Widget box({double height = 16, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            height: 140,
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  box(width: 120),
                  const SizedBox(height: 16),
                  box(),
                  const SizedBox(height: 10),
                  box(),
                  const SizedBox(height: 10),
                  box(),
                  const SizedBox(height: 10),
                  box(),
                  const SizedBox(height: 20),
                  box(width: 100),
                  const SizedBox(height: 8),
                  box(),
                  const SizedBox(height: 6),
                  box(width: 250),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
