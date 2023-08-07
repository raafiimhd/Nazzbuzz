import 'package:flutter/material.dart';
import 'package:nazzbuzz/Screens/whole1.dart';
import 'package:nazzbuzz/homeIcons.dart/search.dart';
import 'package:nazzbuzz/library/liberary.dart';
import '../Settings/settings_main.dart';


class HomeScreen extends StatefulWidget {
  final int initialTabIndex;
  const HomeScreen({Key? key, required this.initialTabIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controllerT;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _currentTabIndex = widget.initialTabIndex;
    super.initState();
    controllerT = TabController(
      vsync: this,
      length: myTab.length,
      initialIndex: _currentTabIndex,
    );
    controllerT!.animateTo(_currentTabIndex);
  }

  @override
  void dispose() {
    controllerT?.dispose();
    super.dispose();
  }

  List<Tab> myTab = [
    const Tab(
      child: Text(
        'SONGS',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Tab(
      child: Text(
        'LIBRARY',
        style: TextStyle(color: Colors.white),
      ),
    )
  ];
  void _handleTabSelection(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double kwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 7, 7),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const SettingsMainScreen()));
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          'Nazz-buzz~~',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(left: kwidth * 0.1),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) =>  SearchScreen()));
                },
                icon: const Icon(Icons.search),
                color: Colors.white,
              )),
        ],
        backgroundColor: Colors.black,
        bottom: TabBar(
          tabs: myTab,
          controller: controllerT,
          indicatorColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: _handleTabSelection,
        ),
      ),
      body: TabBarView(controller: controllerT, children: [
        MainpageScreen(tabController: controllerT!),
        const LiberaryScreen()
      ]
      ),
    );
  }
}
