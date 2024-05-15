import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Done'),
                Tab(text: 'Waiting'),
                Tab(text: 'Cancel'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Done Orders')),
          Center(child: Text('Waiting Orders')),
          Center(child: Text('Cancelled Orders')),
        ],
      ),
    );
  }
}
