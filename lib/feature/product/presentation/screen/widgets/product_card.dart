import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_assessment_task/core/navigation/app_pages.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double originalPrice = product.price / (1 - (product.discountPercentage / 100));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        context.push(AppPages.productDetails, extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
          border: isDark ? Border.all(color: colorScheme.outlineVariant) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: colorScheme.surfaceContainerHighest,
                      child: Hero(
                        tag: 'product_${product.id}',
                        child: CachedNetworkImage(
                          imageUrl: product.thumbnail,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (product.discountPercentage > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${product.discountPercentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: colorScheme.onError,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          product.stock > 0 ? 'Stock: ${product.stock}' : 'Out of stock',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: product.stock < 10 ? colorScheme.error : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.discountPercentage > 0)
                          Text(
                            '\$${originalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 11,
                              color: colorScheme.onSurfaceVariant,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 4),
                            if (product.brand.isNotEmpty)
                              Expanded(
                                child: Text(
                                  product.brand,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: colorScheme.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                          ],
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
    );
  }
}
