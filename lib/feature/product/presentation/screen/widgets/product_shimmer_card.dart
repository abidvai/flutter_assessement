import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerCard extends StatelessWidget {
  const ProductShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: colorScheme.outlineVariant) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
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
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 80,
                          height: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 120,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 40, height: 12, color: Colors.white),
                        Container(width: 50, height: 12, color: Colors.white),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 40,
                          height: 11,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 80,
                          height: 18,
                          color: Colors.white,
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
    );
  }
}
