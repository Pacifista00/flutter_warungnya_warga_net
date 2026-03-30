import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/beauty_product_section.dart';
// import 'package:flutter_warungnya_warga_net/features/home/presentation/section/reward_point_section.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/electronic_product_section.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/home_header.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/latest_product_section.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/special_offer.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/category_section.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: const BottomNav(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeaderSection(),
            SizedBox(height: 16),
            SpecialOfferSection(),
            SizedBox(height: 24),
            CategorySection(),
            SizedBox(height: 24),
            LatestProductSection(),
            SizedBox(height: 32),
            BeautyProductSection(),
            SizedBox(height: 32),
            ElectronicProductSection(),
            SizedBox(height: 32),
            // RewardPointSection(),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
