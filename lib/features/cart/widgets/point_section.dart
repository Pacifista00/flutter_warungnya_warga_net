import 'package:flutter/material.dart';
import 'dart:math';

class PointsSection extends StatefulWidget {
  final int userPoints;
  final int subtotal; // SUDAH setelah voucher
  final ValueNotifier<int> valueNotifier;

  const PointsSection({
    super.key,
    required this.userPoints,
    required this.valueNotifier,
    required this.subtotal,
  });

  @override
  State<PointsSection> createState() => _PointsSectionState();
}

class _PointsSectionState extends State<PointsSection> {
  late TextEditingController controller;

  bool get canUsePoints => widget.subtotal >= 5000 && widget.userPoints > 0;

  int get allowedPoints {
    int maxPointsBySubtotal = widget.subtotal ~/ 5000;
    return min(maxPointsBySubtotal, widget.userPoints);
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.valueNotifier.value.toString(),
    );
  }

  void updateValue(String value) {
    int newValue = int.tryParse(value) ?? 0;

    if (newValue < 0) newValue = 0;
    if (newValue > allowedPoints) newValue = allowedPoints;

    controller.text = newValue.toString();
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    widget.valueNotifier.value = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gunakan Poin",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text("Poin tersedia: ${widget.userPoints}"),
            Text("Maksimal poin: $allowedPoints"),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              enabled: canUsePoints,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                helperText: "1 poin = Rp5000",
              ),
              onChanged: updateValue,
            ),
          ],
        ),
      ),
    );
  }
}
