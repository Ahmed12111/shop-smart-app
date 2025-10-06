import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// You would define a main() function and run MyApp()

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Defines the primary color for elements like the microphone icon
    const Color primaryPurple = Color(0xFF9775FA);
    
    // Debug print to confirm HomeScreen is being used
    print('HomeScreen: Building with updated layout');

    return Scaffold(
      // 7. Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavBar(),
      
      // 1. & 2. Header and Welcome Section
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            // 1. Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1), 
                      ),
                    ],
                  ),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. Welcome Section
            const Text(
              'Hello',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Welcome to Laza.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 25),

            // 3. Search Bar
            _buildSearchBar(primaryPurple),
            const SizedBox(height: 30),

            // 4. Choose Brand Section Header
            _buildSectionHeader('Choose Brand'),
            const SizedBox(height: 15),

            // 4. Brand List (Horizontal Scroll)
            _buildBrandList(),
            const SizedBox(height: 30),

            // 5. New Arrival Section Header
            _buildSectionHeader('New Arraival'),
            const SizedBox(height: 15),

            // 5. Product Grid (Two Columns)
            _buildProductGrid(),
            const SizedBox(height: 80), // Increased bottom padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'View All',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSearchBar(Color accentColor) {
    return Row(
      children: [
        // Search Input Field
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA), // Light grey background
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Voice Search Button
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.mic, color: Colors.white),
        ),
      ],
    );
  }
  
  Widget _buildBrandItem({required String name, required String imagePath}) {
    bool isSelected = name == 'Nike';
    
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF292929) : const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display the brand logo
          _buildBrandLogo(imagePath, isSelected),
          const SizedBox(width: 4),
          // Display the brand name
          Flexible(
            child: Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo(String imagePath, bool isSelected) {
    // Check if it's an SVG file
    if (imagePath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        width: 16,
        height: 16,
        fit: BoxFit.contain,
        colorFilter: isSelected 
          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        placeholderBuilder: (context) => Icon(
          Icons.image, 
          size: 16, 
          color: isSelected ? Colors.white : Colors.black
        ),
      );
    }
    
    // For PNG files, use Image.asset
    return Image.asset(
      imagePath,
      width: 16,
      height: 16,
      fit: BoxFit.contain,
      color: isSelected ? Colors.white : Colors.black,
      errorBuilder: (context, error, stackTrace) {
        // Debug print to see what's happening
        print('Failed to load image: $imagePath');
        print('Error: $error');
        // Fallback to icon if image fails to load
        return Icon(
          Icons.image, 
          size: 16, 
          color: isSelected ? Colors.white : Colors.black
        );
      },
    );
  }

  Widget _buildBrandList() {
    // In a real app, 'imagePath' would be used to display the logo.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildBrandItem(name: 'Adidas', imagePath: 'assets/home_screen_assets/adidas_logo.png'),
          _buildBrandItem(name: 'Nike', imagePath: 'assets/home_screen_assets/nike_logo.png'),
          _buildBrandItem(name: 'Fila', imagePath: 'assets/home_screen_assets/fila_logo.svg'),
          _buildBrandItem(name: 'Puma', imagePath: 'assets/home_screen_assets/puma_logo.svg'),
          _buildBrandItem(name: 'Reebok', imagePath: 'assets/home_screen_assets/reebok_logo.svg'),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    // Using GridView.builder for the product layout
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // To allow parent SingleChildScrollView to handle scrolling
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.85, // Further increased ratio to prevent overflow
      ),
      itemCount: 4, // Showing 4 items as per the screenshot
      itemBuilder: (context, index) {
        return _buildProductCard(index);
      },
    );
  }

  Widget _buildProductCard(int index) {
    // Product card structure
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Image
        AspectRatio(
          aspectRatio: 1.2,
          child: Stack(
            children: [
              // Placeholder for the product image
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.lightGreen.shade100 : Colors.yellow.shade100, // Placeholder color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Icon(Icons.image_outlined, size: 35, color: Colors.grey)),
              ),
              // Heart/Favorite Icon
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, size: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Product Details
        const Text(
          'Nike Sportswear Club Fleece',
          style: TextStyle(fontSize: 10, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        const Text(
          '\$99',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // To show all labels
      selectedItemColor: const Color(0xFF9775FA),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Bag',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}