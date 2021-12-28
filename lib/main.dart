import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '폰광봉',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyTabbedPage(),
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  final List<String> tabTitles = ['내 폰광봉', '인터넷에서 폰광봉 찾기'];
  final List<Widget> tabIcons = [
    const FaIcon(FontAwesomeIcons.magic),
    const Icon(Icons.public)
  ];

  int _currentIndex = 0;

  late TabController _tabController;

  List<Tab> getTabs() {
    List<Tab> result = [];
    for (var i = 0; i < tabTitles.length; i++) {
      result.add(Tab(text: tabTitles[i], icon: tabIcons[i]));
    }
    return result;
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitles.length);
    _tabController.addListener(_handleTabSelection);
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
        title: Text(tabTitles[_currentIndex]),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: TabBar(
          controller: _tabController,
          tabs: getTabs(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [Text("내 폰광봉"), Text("아직 준비 중입니다.")],
      ),
    );
  }
}
