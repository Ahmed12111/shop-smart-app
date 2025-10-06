import 'package:flutter/material.dart';

// Placeholder images from picsum.photos (reliable for demos)
const String _mainImageUrl = 'https://i.ibb.co/PRkGz8j/T1.png';
const List<String> _thumbnailUrls = [
  'https://i.ibb.co/Pv1tPqDj/T2.png',
  'https://i.ibb.co/sLY9Qrv/T3.png',
  'https://i.ibb.co/hJmhCNVS/T4.png',
  'https://i.ibb.co/jkcn237D/T5.png',
];
const String _reviewerImageUrl = 'https://i.ibb.co/PRkGz8j/T1.png';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _selectedMainImageUrl = _mainImageUrl;
  int _selectedThumbnailIndex = -1; // none selected by default
  int _selectedSizeIndex = 1; // default select 'M'
  static const List<String> _sizes = ['S', 'M', 'L', 'XL', '2XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Set the background to white and elevation to 0 for a clean look
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      // Use SingleChildScrollView to ensure content is scrollable
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Main Product Image Section
            AspectRatio(
              aspectRatio: 1 / 1, // Square aspect ratio for the image area
              child: Image.network(
                _selectedMainImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 2. Product Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Men's Printed Pullover Hoodie",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Nike Club Fleece",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "\$120",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 3. Image Thumbnails & Size Guide
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: _thumbnailUrls
                            .asMap()
                            .entries
                            .map((entry) {
                          final int index = entry.key;
                          final String url = entry.value;
                          final bool isSelected = index == _selectedThumbnailIndex;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMainImageUrl = url;
                                  _selectedThumbnailIndex = index;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? Colors.black : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const Text(
                        "Size Guide",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 4. Size Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _sizes.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final String size = entry.value;
                      return _SizeButton(
                        label: size,
                        isSelected: index == _selectedSizeIndex,
                        onTap: () {
                          setState(() {
                            _selectedSizeIndex = index;
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // 5. Description
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      children: [
                        const TextSpan(
                          text: "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with ",
                        ),
                        TextSpan(
                          text: "Read More..",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor, // Use theme color for link
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 6. Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Single Review Item
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_reviewerImageUrl),
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Ronald Richards",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "4.8 rating",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(5, (index) => Icon(
                                        index < 5 // Assuming 5 stars filled for 4.8
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 14,
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "13 Sep, 2020",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Separator for the bottom section
            const Divider(height: 1),

            // 7. Total Price Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total Price",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$125",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80), // Space for the fixed bottom bar
          ],
        ),
      ),
      // 8. Fixed Bottom "Add to Cart" Button
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        color: const Color(0xFF9966FF), // Approximate purple color
        child: const Text(
          "Add to Cart",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Helper Widget for Size Buttons
class _SizeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _SizeButton({
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}