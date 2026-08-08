import 'package:flutter_assessment_task/core/navigation/app_pages.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';
import 'package:flutter_assessment_task/feature/product/presentation/screen/product_detail_screen.dart';
import 'package:flutter_assessment_task/feature/product/presentation/screen/splash_screen.dart';
import 'package:flutter_assessment_task/custom_bottom_nav.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppPages.splash,
  routes: [
    GoRoute(
      path: AppPages.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppPages.homeScreen,
      builder: (context, state) => const CustomBottomNav(),
    ),
    GoRoute(
      path: AppPages.productDetails,
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailScreen(product: product);
      },
    ),
  ],
);
