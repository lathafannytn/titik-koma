import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tikom/ui/screen/login/signup.dart';
import 'package:tikom/utils/storage_service.dart';
import 'package:tikom/ui/screen/dashboard/home.dart';
import 'package:tikom/ui/screen/login/signin.dart';
import 'package:tikom/ui/screen/product/drinks_menu.dart';
import 'package:tikom/ui/screen/order/order.dart';
import 'package:tikom/ui/screen/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init(); // Inisialisasi GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Color(0xFFF5F5F3),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[200],
          selectedLabelStyle:
              GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        ),
      ),
      home: FutureBuilder<String?>(
        future: StorageService.getData('token'),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return MyHomePage();
            } else {
              return const SignIn();
              // return const SignUp(email: 's15011@gmail.com',);
              
            }
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    DrinksMenuPage(),
    // SignIn(),
    OrdersPage(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: SvgPicture.asset('assets/icons/home.svg', width: 24, height: 24),
            activeIcon: SvgPicture.asset('assets/icons/home.svg', width: 24, height: 24, color: Theme.of(context).primaryColor),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: SvgPicture.asset('assets/icons/menu.svg', width: 24, height: 24),
            activeIcon: SvgPicture.asset('assets/icons/menu.svg', width: 24, height: 24, color: Theme.of(context).primaryColor),
          ),
          BottomNavigationBarItem(
            label: 'Order',
            icon: SvgPicture.asset('assets/icons/transaction.svg', width: 24, height: 24),
            activeIcon: SvgPicture.asset('assets/icons/transaction.svg', width: 24, height: 24, color: Theme.of(context).primaryColor),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: SvgPicture.asset('assets/icons/profile.svg', width: 24, height: 24),
            activeIcon: SvgPicture.asset('assets/icons/profile.svg', width: 24, height: 24, color: Theme.of(context).primaryColor),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[800],
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    );
  }
}

