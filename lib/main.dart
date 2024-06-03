import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tikom/data/blocs/fetch_add_on_product/add_on_product_cubit.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_cubit.dart';
import 'package:tikom/data/blocs/user_data/user_data_cubit.dart';
import 'package:tikom/ui/screen/login/signup.dart';
import 'package:tikom/ui/screen/order/add_on.dart';
import 'package:tikom/ui/screen/order/history.dart';
import 'package:tikom/utils/storage_service.dart';
import 'package:tikom/ui/screen/dashboard/home.dart';
import 'package:tikom/ui/screen/login/signin.dart';
import 'package:tikom/ui/screen/product/drinks_menu.dart';
import 'package:tikom/ui/screen/order/history_order.dart';
import 'package:tikom/ui/screen/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/screen/order/add_on.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init(); // Initialize GetStorage
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserDataCubit userDataCubit;

  @override
  void initState() {
    super.initState();

    userDataCubit = UserDataCubit()..loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDataCubit>(
          create: (context) => userDataCubit,
        ),
        BlocProvider<ProductDetailDataCubit>(
          create: (context) => ProductDetailDataCubit(),
        ),
        BlocProvider<AddOnProductDataCubit>(
          create: (context) => AddOnProductDataCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Titik Koma',
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
                return const MyHomePage(tabIndex: 0);
              } else {
                return const SignIn();
              }
            }
          },
        ),
      ),
      // routes: {
      //   '/addon': (context) => AddOnScreen(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int tabIndex;
  const MyHomePage({Key? key, required this.tabIndex}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    DrinksMenuPage(),
    RiwayatPemesananScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              color: _selectedIndex == 0 ? Colors.green : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              width: 24,
              height: 24,
              color: _selectedIndex == 1 ? Colors.green : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'My Order',
            icon: SvgPicture.asset(
              'assets/icons/transaction.svg',
              width: 24,
              height: 24,
              color: _selectedIndex == 2 ? Colors.green : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Saya',
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
              color: _selectedIndex == 3 ? Colors.green : Colors.grey,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
