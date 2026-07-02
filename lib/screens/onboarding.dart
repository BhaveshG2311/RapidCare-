import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingSlide> _slides = [
    const OnboardingSlide(
      title: 'Fastest Response',
      description: 'Emergency services dispatched instantly to your exact location with priority routing.',
      icon: Icons.speed,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC_9VV5pE6tkzHpbhWSVePnFXKa8kugTxZkC6-s4iBzq684_UHAndpM8Jwh63n7XceKgmAFe0c0td5wIu7DmNz3RFuvAn7-qD56pNs1Qnj2fKGhTkVeWvWkSCXeL30DFNMbpkP77yvAwmaHgON08Q6FKEC72wvqj9vcvMRtoxxDOuHII_lfzV4GmeBUiSoGfQVkAOAhxzDdocKIWIARz2aPkNyd2OohFrN9XA43UdB8ZEwmslMaBz0Pl_z83yMNg_muAnq9TCo6sHs',
    ),
    const OnboardingSlide(
      title: 'Expert Care',
      description: 'Highly trained paramedics equipped with advanced life-saving technology en route.',
      icon: Icons.health_and_safety,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8SmlRBWJuQJRjDYdS9oAhhxnl_bHmLMho_V9JK4SJ0TS_BsD5saq5zHllXJZV_NCdeHbLKERGx1ejmqA_ZDV-GbmciBG8jOD1eOQw5ZvCoCD22fWKzDCQyO7ftuQUhk0VP_8h355i1xpECMa5bVZYCuTgSQFngjzsaYStwRw8GyLpnKqQP2vq5WNaGmDYw_r-uNi7tdJ6CmLNEH6bJmAlmtkkFDKnWdo0Jawjzqt-L3Py-0GVPoA__ovrj8GSIpaG-zDwN85Ifr0',
    ),
    const OnboardingSlide(
      title: 'Real-time Tracking',
      description: 'Track your assigned ambulance live and share vital ETA data directly with hospitals.',
      icon: Icons.track_changes,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCsGWlKLENuig8jrRhj-MGjSV3ecc50shau3htm_pRHNHb64S5-PBVbfEwO8SPl8d3us9m25FevoWafH2UFFZiSIIb1gxuPmuT-rXvUqvjL2AzwK8dSoLSn2wwsiAUjqhRczJvc-345nLhpy2u_r_H95Y8PWgeFTLl1xNnv--jfaVeJ4I1sn94XD2dqWmOLWPSAfnsM02jKRUUdAnpuCwEoodBWDvcwbUdXiITjUcVbyeB8bg84xzhWfRNUwQaxQGp_TZtI3XfKYHU',
      showOverlayBadge: true,
    ),
  ];

  void _onNextPressed() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top action bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emergency, color: theme.colorScheme.primary, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'RapidCare',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _navigateToLogin,
                    child: Text(
                      'Skip',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Carousel Viewport
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Slide Image Container
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                children: [
                                  Image.network(
                                    slide.imageUrl,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: theme.colorScheme.surfaceContainerLow,
                                      child: Icon(
                                        slide.icon,
                                        size: 72,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                  ),
                                  
                                  // Gradient overlay
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.2),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                  // Real-time tracking badge overlay for Slide 3
                                  if (slide.showOverlayBadge)
                                    Positioned(
                                      bottom: 16,
                                      left: 16,
                                      right: 16,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.surface.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary.withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.location_on,
                                                color: theme.colorScheme.primary,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ETA: 4 Mins',
                                                  style: theme.textTheme.labelLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Approaching swiftly',
                                                  style: theme.textTheme.labelMedium?.copyWith(
                                                    color: theme.colorScheme.onSurfaceVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        // Slide Texts
                        Text(
                          slide.title,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            slide.description,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Bottom control area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Action Button
                  ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_currentIndex == _slides.length - 1 ? 'Get Started' : 'Next'),
                        const SizedBox(width: 8),
                        Icon(
                          _currentIndex == _slides.length - 1 ? Icons.check : Icons.arrow_forward,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingSlide {
  final String title;
  final String description;
  final IconData icon;
  final String imageUrl;
  final bool showOverlayBadge;

  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.imageUrl,
    this.showOverlayBadge = false,
  });
}
