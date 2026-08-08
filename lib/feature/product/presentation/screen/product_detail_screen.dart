import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double originalPrice = product.price / (1 - (product.discountPercentage / 100));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Product Details',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              color: colorScheme.surfaceContainerHighest,
              child: Hero(
                tag: 'product_${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              transform: Matrix4.translationValues(0, -32, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            product.category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurfaceVariant,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                        height: 1.2,
                      ),
                    ),
                    if (product.brand.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'By ${product.brand}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (product.discountPercentage > 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '\$${originalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: colorScheme.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        const Spacer(),
                        if (product.discountPercentage > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '-${product.discountPercentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: colorScheme.onError,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: product.stock < 10 
                            ? colorScheme.errorContainer.withValues(alpha: 0.5) 
                            : isDark ? Colors.green.shade900.withValues(alpha: 0.3) : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: product.stock < 10 
                              ? colorScheme.errorContainer 
                              : isDark ? Colors.green.shade800 : Colors.green.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            product.stock < 10 ? Icons.warning_amber_rounded : Icons.check_circle_outline_rounded,
                            color: product.stock < 10 ? colorScheme.error : Colors.green,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            product.stock > 0 
                                ? 'Hurry! Only ${product.stock} items left in stock.'
                                : 'Out of stock at the moment.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: product.stock < 10 
                                  ? (isDark ? colorScheme.error : colorScheme.error.withValues(alpha: 0.8)) 
                                  : (isDark ? Colors.greenAccent : Colors.green.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
          ],
          border: isDark ? Border(top: BorderSide(color: colorScheme.outlineVariant)) : null,
        ),
        child: SafeArea(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  color: colorScheme.onSurface,
                  iconSize: 28,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}