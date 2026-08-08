import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_assessment_task/core/navigation/app_pages.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppPages.homeScreen);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: 80,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Flutter\nAssessment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    height: 1.2,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your premium shopping experience',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}