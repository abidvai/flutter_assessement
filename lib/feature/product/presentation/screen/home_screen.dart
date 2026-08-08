import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_assessment_task/feature/product/presentation/provider/product_provider.dart';
import 'package:flutter_assessment_task/feature/product/presentation/screen/widgets/product_card.dart';
import 'package:flutter_assessment_task/feature/product/presentation/screen/widgets/product_shimmer_card.dart';
import 'package:flutter_assessment_task/core/theme/provider/theme_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchProducts(limit: 30, skip: 0);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset >= 400 && !_showBackToTopButton) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else if (_scrollController.offset < 400 && _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = false;
      });
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = ref.read(productProvider);
      if (!state.isLoading && state.hasMore) {
        ref
            .read(productProvider.notifier)
            .fetchProducts(limit: 30, skip: state.products.length);
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Flutter Asessment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode,
              color: colorScheme.onSurface,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
              ),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  ref.read(productProvider.notifier).fetchProducts(limit: 30, skip: 0);
                } else {
                  ref.read(productProvider.notifier).searchProducts(value.trim());
                }
              },
            ),
          ),
          Expanded(
            child: productState.products.isEmpty && productState.isLoading
                ? GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: 6, // Show 6 shimmer items
                    itemBuilder: (context, index) {
                      return const ProductShimmerCard();
                    },
                  )
                : productState.products.isEmpty && productState.error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                if (theme.brightness == Brightness.light)
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                              ],
                              border: theme.brightness == Brightness.dark
                                  ? Border.all(color: colorScheme.outlineVariant)
                                  : null,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colorScheme.errorContainer.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.wifi_off_rounded,
                                    size: 48,
                                    color: colorScheme.error,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Oops! Something went wrong',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  productState.error!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ref.read(productProvider.notifier).fetchProducts(limit: 30, skip: 0);
                                    },
                                    icon: const Icon(Icons.refresh_rounded),
                                    label: const Text('Try Again'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await ref.read(productProvider.notifier).fetchProducts(
                                limit: 30,
                                skip: 0,
                              );
                        },
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.65,
                          ),
                          itemCount: productState.products.length,
                          itemBuilder: (context, index) {
                            final product = productState.products[index];
                            return ProductCard(product: product);
                          },
                        ),
                      ),
          ),
          if (productState.isLoading && productState.products.isNotEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 4,
              child: const Icon(Icons.arrow_upward_rounded),
            )
          : null,
    );
  }
}

