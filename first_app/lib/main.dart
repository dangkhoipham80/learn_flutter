import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Tracking App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          // Map Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
            ),
            child: Stack(
              children: [
                // Map Content
                Positioned.fill(
                  top: 120,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Map circles and car
                        Center(
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4F46E5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Parking spots
                        Positioned(
                          top: 50,
                          left: 50,
                          child: _buildParkingSpot(),
                        ),
                        Positioned(
                          bottom: 100,
                          right: 60,
                          child: _buildParkingSpot(),
                        ),

                        // Buildings
                        Positioned(top: 80, left: 20, child: _buildBuilding()),
                        Positioned(
                          top: 120,
                          right: 40,
                          child: _buildHospital(),
                        ),
                        Positioned(
                          bottom: 150,
                          left: 40,
                          child: _buildBuilding(),
                        ),

                        // Street names
                        const Positioned(
                          left: 80,
                          top: 200,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              'Đường Bà Huyện Thanh Quan',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          right: 20,
                          bottom: 200,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              'Đường Nam Kỳ Khởi Nghĩa',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Buttons
                Positioned(
                  bottom: 150,
                  left: 20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6366F1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  right: 20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6366F1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                // Quick Access Icons
                Positioned(
                  bottom: 80,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickAccess(Icons.home, 'Nhà'),
                      _buildQuickAccess(Icons.shopping_cart, 'Chợ'),
                      _buildQuickAccess(Icons.fitness_center, 'Gym'),
                      _buildQuickAccess(Icons.account_balance, 'Bank'),
                    ],
                  ),
                ),

                // Search Bar
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[600]),
                        const SizedBox(width: 15),
                        Text(
                          'Tìm điểm đến của bạn',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.mic, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _scaffoldKey.currentState?.openDrawer(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Map',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Location Card
          Positioned(
            top: 140,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEC4899),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bãi đậu xe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Nguyễn Đình Chiểu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Đường Nguyễn Đình Chiểu',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _buildParkingSpot() {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        color: Color(0xFFEC4899),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBuilding() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.account_balance, color: Colors.white, size: 12),
    );
  }

  Widget _buildHospital() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.local_hospital, color: Colors.white, size: 12),
    );
  }

  Widget _buildQuickAccess(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF6366F1)),
          ),
          child: Icon(icon, color: const Color(0xFF6366F1), size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6366F1),
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phạm Đăng Khôi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'TpHCM, Việt Nam',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.settings, color: Colors.grey[600], size: 24),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem('Xe của tôi'),
                  _buildMenuItem('Gần bạn'),
                  _buildMenuItem('Đã lưu'),
                  _buildMenuItem('Lịch sử'),
                  _buildMenuItem('Thanh toán'),
                  _buildMenuItem('Dịch vụ khác'),
                  _buildMenuItem('Cộng đồng'),
                ],
              ),
            ),

            // Logout Button
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.logout, color: Colors.red[400], size: 16),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Thoát',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
