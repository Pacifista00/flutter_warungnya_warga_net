import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'onboarding_controller.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Mulai Lebih Mudah',
      description:
          'Temukan produk impianmu dengan kualitas terbaik. Pengalaman belanja yang mudah, cepat, dan pastinya bikin kamu senyum terus. ',
      image: 'assets/images/onboarding/000.jpg',
    ),
    OnboardingItem(
      title: 'Belanja Tanpa Rasa Khawatir',
      description:
          'Setiap pembelianmu dilindungi oleh garansi penuh. Belanja lebih tenang dengan sistem pembayaran yang terjamin keamanannya.  ',
      image: 'assets/images/onboarding/000.jpg',
    ),
    OnboardingItem(
      title: 'Pilih Tanpa Ribet',
      description:
          'Jelajahi ribuan koleksi produk berkualitas dan dapatkan barang favoritmu lebih mudah tanpa perlu menunggu lama.',
      image: 'assets/images/onboarding/000.jpg',
    ),
    OnboardingItem(
      title: 'Siap Untuk Mulai Belanja?',
      description:
          'Mulai cari barang impianmu hari ini. Masuk ke akunmu untuk melihat daftar keinginan, atau langsung mulai mencari produk favoritmu sekarang.',
      image: 'assets/images/onboarding/000.jpg',
    ),
  ];

  void _next() async {
    if (_currentIndex == _items.length - 1) {
      await ref.read(onboardingProvider.notifier).finishOnboarding();
      if (mounted) context.go('/home');
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _back() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 1. AREA GAMBAR (Bisa digeser/slide)
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _items.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return SizedBox.expand(
                  child: Image.asset(_items[index].image, fit: BoxFit.cover),
                );
              },
            ),
          ),

          /// 2. KONTEN TEKS (Hanya transisi fade/muncul, tidak ikut geser)
          Container(
            width: double.infinity,
            transform: Matrix4.translationValues(
              0,
              -35,
              0,
            ), // Menindih gambar sedikit
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Efek Fade (Transparan ke Muncul)
                return FadeTransition(opacity: animation, child: child);
              },
              // Key sangat penting agar Flutter tahu kontennya berubah
              child: Column(
                key: ValueKey<int>(_currentIndex),
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _items[_currentIndex].title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _items[_currentIndex].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 3. NAVIGASI (Indicator & Buttons)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              children: [
                /// INDICATOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _items.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index
                                ? Colors.blue
                                : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                /// BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _currentIndex == 0 ? null : _back,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Kembali'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          _currentIndex == _items.length - 1
                              ? 'Mulai'
                              : 'Lanjut',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
