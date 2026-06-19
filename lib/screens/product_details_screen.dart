import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/favorites_provider.dart';
import 'package:shop_app/screens/custom%20Widget/product_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(product.title)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductCard(product: product),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Consumer<CartProvider>(
                          builder: (context, cart, child) {
                            final isInCart = cart.isInCart(product);

                            return ElevatedButton.icon(
                              onPressed: () {
                                if (isInCart) {
                                  cart.removeFromCart(product);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم إزالة المنتج من السلة'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else {
                                  cart.addToCart(product);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'تم إضافة المنتج إلى السلة',
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                isInCart
                                    ? Icons.shopping_cart
                                    : Icons.add_shopping_cart,
                              ),
                              label: Text(
                                isInCart ? 'إزالة من السلة' : 'إضافة للسلة',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isInCart
                                    ? Colors.orange
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Consumer<FavoritesProvider>(
                          builder: (context, favorites, child) {
                            final isFavorite = favorites.isFavorite(product);

                            return OutlinedButton.icon(
                              onPressed: () {
                                favorites.toggleFavorite(product);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isFavorite
                                          ? 'تم إزالة المنتج من المفضلة'
                                          : 'تم إضافة المنتج إلى المفضلة',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : Theme.of(context).colorScheme.primary,
                              ),
                              label: Text(
                                isFavorite ? 'إزالة المفضلة' : 'إضافة للمفضلة',
                              ),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
