import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'doctor_page.dart';
import 'health_page.dart';
import 'history_page.dart';
import 'talk_with_ai_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    HealthPage(),
    Container(),
    DoctorPage(),
    TalkWithAIPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Handle camera separately
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.green : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: _selectedIndex == 1 ? Colors.red : Colors.grey),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.camera, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3 ? Colors.green : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,
                color: _selectedIndex == 4 ? Colors.purple : Colors.grey),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image1;
  File? _image2;

  Future<void> _captureImages() async {
    final picker = ImagePicker();
    final pickedFile1 = await picker.pickImage(source: ImageSource.camera);
    final pickedFile2 = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile1 != null && pickedFile2 != null) {
      setState(() {
        _image1 = File(pickedFile1.path);
        _image2 = File(pickedFile2.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Enable scrolling to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text('HELLO,',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('ALEX',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const SizedBox(height: 20),
              Container(
                height: 150,
                color: Colors.grey[300],
                child: const Center(child: Text('Image Placeholder')),
              ),
              const SizedBox(height: 20),

              /// Buttons - Now in a Column for better scrolling
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavButton(
                          context, Icons.favorite, 'Health', HealthPage()),
                      _buildNavButton(
                          context, Icons.person, 'Doctor', DoctorPage()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavButton(
                          context, Icons.history, 'History', HistoryPage()),
                      _buildNavButton(context, Icons.chat, 'Talk with AI',
                          TalkWithAIPage()),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Center(
                child: FloatingActionButton(
                  onPressed: _captureImages,
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context, IconData icon, String label, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        minimumSize: const Size(140, 60), // Equal button size
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 5),
          Text(label,
              style: const TextStyle(
                  fontSize: 16, color: Colors.blue)), // Blue text
        ],
      ),
    );
  }
}
