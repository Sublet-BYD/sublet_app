import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Owner/manage_properties.dart';
import 'package:sublet_app/screens/Owner/new_property.dart';
import 'package:sublet_app/widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  var _screenIndex = 0;
  void _startAddNewProperty(BuildContext context) {
    // The half window for adding new property
    showModalBottomSheet(
      context: context,
      builder: (context) => const NewProperty(),
    );
  }

  late final List<CustomTabItem> _tabs;

  AppBar get appBar => AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_tabs[_screenIndex].label),
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: _tabs
              .map(
                (e) => Tab(
                  icon: e.icon,
                ),
              )
              .toList(),
          onTap: (value) {
            setState(() {
              _screenIndex = value;
            });
          },
        ),
      );

  _init() {
    _tabs = [
      CustomTabItem(
        label: 'Manage Properties',
        icon: const Icon(Icons.holiday_village),
        screen: const ManageProperties(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _startAddNewProperty(context),
        ),
      ),
      CustomTabItem(
        label: 'Customers',
        icon: const Icon(Icons.contact_mail_rounded),
        screen: Container(),
      ),
    ];
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _tabs.map((e) => e.screen).toList(),
      ),
      floatingActionButton: _tabs[_screenIndex].floatingActionButton,
    );
  }
}

class CustomTabItem {
  final String label;
  final Icon icon;
  final Widget screen;
  FloatingActionButton? floatingActionButton;

  CustomTabItem({
    required this.label,
    required this.icon,
    required this.screen,
    this.floatingActionButton,
  });
}
