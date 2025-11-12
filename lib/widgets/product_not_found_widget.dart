import 'package:flutter/material.dart';

// Reusable Not Found Widget
class ProductNotFoundWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onRetry;

  const ProductNotFoundWidget({
    super.key,
    this.title = 'No Products Found',
    this.subtitle = 'We couldn\'t find any products matching your search',
    this.icon = Icons.search_off,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 80, color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            if (onRetry != null) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueAccent,
                  iconColor: Colors.white,
                  iconSize: 20,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Example usage in a search screen
class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  List<String> products = [];
  bool isSearching = false;
  String searchQuery = '';

  void searchProducts(String query) {
    setState(() {
      searchQuery = query;
      isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        // Simulate search results - empty for demo
        products = [];
        isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products'), elevation: 0),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: searchProducts,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),

          // Content area
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : products.isEmpty && searchQuery.isNotEmpty
                ? ProductNotFoundWidget(
                    title: 'No Results Found',
                    subtitle: 'Try adjusting your search terms or filters',
                    icon: Icons.inventory_2_outlined,
                    onRetry: () {
                      // Clear search or trigger new search
                      searchProducts(searchQuery);
                    },
                  )
                : searchQuery.isEmpty
                ? const Center(child: Text('Start searching for products'))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(products[index]));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Alternative compact version for smaller spaces
class CompactNotFoundWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const CompactNotFoundWidget({
    super.key,
    this.message = 'No results found',
    this.icon = Icons.search_off,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
