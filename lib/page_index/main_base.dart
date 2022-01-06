import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main_my_sticks.dart';
import 'add_stick.dart';

class TabbedPage extends StatefulWidget {
  const TabbedPage({Key? key}) : super(key: key);
  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage>
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
        children: [MySticksPage(), const Text("아직 준비 중입니다.")],
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const AddStickPage()));}, backgroundColor: Colors.blue, child: const Icon(Icons.add),) : null,
    );
  }
}
