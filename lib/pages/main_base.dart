import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_modify_stick.dart';
import 'main_my_sticks.dart';

class TabbedPage extends StatefulWidget {
  const TabbedPage({Key? key}) : super(key: key);
  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabTitles = ['내 폰광봉', '인터넷에서 폰광봉 찾기'];
  final List<Widget> _tabIcons = [
    const FaIcon(FontAwesomeIcons.magic),
    const Icon(Icons.public)
  ];
  final GlobalKey<MySticksPageState> _mySticksPageState =
      GlobalKey<MySticksPageState>();

  int _currentIndex = 0;

  late TabController _tabController;

  List<Tab> getTabs() {
    List<Tab> result = [];
    for (var i = 0; i < _tabTitles.length; i++) {
      result.add(Tab(text: _tabTitles[i], icon: _tabIcons[i]));
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
    _tabController = TabController(vsync: this, length: _tabTitles.length);
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
        title: Text(_tabTitles[_currentIndex]),
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
        children: [
          MySticksPage(key: _mySticksPageState),
          const Text("아직 준비 중입니다.")
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddModifyStickPage(
                            param: PageParam(PageMode.add, null)))).then((_) {
                  _mySticksPageState.currentState!.getSticks();
                });
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
