import 'package:flutter/material.dart';

void main() {
  runApp(const MyShopMiniApp());
}

class MyShopMiniApp extends StatelessWidget {
  const MyShopMiniApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop Mini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Model untuk Kategori
class Category {
  final String name;
  final IconData icon;
  final Color color1;
  final Color color2;

  Category({
    required this.name,
    required this.icon,
    required this.color1,
    required this.color2,
  });
}

// Model untuk Produk
class Product {
  final String name;
  final double price;
  final IconData icon;
  final String category;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.icon,
    required this.category,
    required this.description,
  });
}

// Home Screen dengan daftar kategori
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category(
        name: 'Makanan',
        icon: Icons.restaurant_menu,
        color1: Color(0xFFFF6B6B),
        color2: Color(0xFFFF8E53),
      ),
      Category(
        name: 'Minuman',
        icon: Icons.local_cafe,
        color1: Color(0xFF4ECDC4),
        color2: Color(0xFF44A08D),
      ),
      Category(
        name: 'Elektronik',
        icon: Icons.devices,
        color1: Color(0xFF667EEA),
        color2: Color(0xFF764BA2),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar dengan animasi
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeTransition(
                              opacity: _animationController,
                              child: Text(
                                'MyShop Mini',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(-1, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.easeOutCubic,
                              )),
                              child: Text(
                                'Belanja Mudah & Cepat',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.deepPurple, Colors.purpleAccent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.shopping_bag, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Search Bar dengan shadow
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari produk...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kategori Produk',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${categories.length} Items',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Grid Categories dengan animasi
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            index * 0.2,
                            0.6 + (index * 0.2),
                            curve: Curves.easeOutCubic,
                          ),
                        )),
                        child: CategoryCard(
                          category: categories[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    ProductListScreen(categoryName: categories[index].name),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
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

// Widget Card untuk Kategori dengan desain premium
class CategoryCard extends StatefulWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.category.color1, widget.category.color2],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.category.color1.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        widget.category.icon,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.category.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Lihat produk',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen untuk daftar produk berdasarkan kategori
class ProductListScreen extends StatefulWidget {
  final String categoryName;

  const ProductListScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _getProductsByCategory() {
    final allProducts = [
      Product(name: 'Nasi Goreng', price: 15000, icon: Icons.rice_bowl, category: 'Makanan', description: 'Nasi goreng spesial dengan bumbu rempah pilihan'),
      Product(name: 'Mie Ayam', price: 12000, icon: Icons.ramen_dining, category: 'Makanan', description: 'Mie ayam dengan topping ayam premium'),
      Product(name: 'Sate Ayam', price: 20000, icon: Icons.kebab_dining, category: 'Makanan', description: 'Sate ayam dengan bumbu kacang khas'),
      Product(name: 'Es Teh', price: 5000, icon: Icons.local_cafe, category: 'Minuman', description: 'Es teh manis segar dan nikmat'),
      Product(name: 'Jus Jeruk', price: 8000, icon: Icons.local_drink, category: 'Minuman', description: 'Jus jeruk segar tanpa pengawet'),
      Product(name: 'Kopi', price: 10000, icon: Icons.coffee, category: 'Minuman', description: 'Kopi arabica pilihan dengan aroma khas'),
      Product(name: 'Laptop', price: 5000000, icon: Icons.laptop, category: 'Elektronik', description: 'Laptop dengan spesifikasi tinggi'),
      Product(name: 'Smartphone', price: 3000000, icon: Icons.phone_android, category: 'Elektronik', description: 'Smartphone dengan kamera berkualitas'),
      Product(name: 'Headphone', price: 500000, icon: Icons.headphones, category: 'Elektronik', description: 'Headphone dengan noise cancellation'),
    ];

    return allProducts.where((p) => p.category == widget.categoryName).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _getProductsByCategory();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.categoryName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            '${products.length} Produk Tersedia',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Product Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  ProductDetailScreen(product: product),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                      );
                    },
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

// Widget Card untuk Produk dengan desain modern
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon dengan background gradient
            Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade100,
                    Colors.purple.shade50,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    product.icon,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
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

// Screen untuk detail produk dengan desain premium
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade400,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              
              // Product Icon
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    product.icon,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Detail Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, size: 16, color: Colors.orange),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        Row(
                          children: [
                            Icon(Icons.local_shipping, size: 20, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'Gratis ongkir untuk pembelian ini',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        
                        const Spacer(),
                        
                        // Price and Button
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Harga',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp ${product.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} ditambahkan ke keranjang'),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.shopping_cart, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'Tambah ke Keranjang',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
