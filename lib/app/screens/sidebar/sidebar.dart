import 'package:flutter/material.dart';
import 'package:letterdude/app/screens/sidebar/activity.dart';
import 'package:letterdude/app/screens/sidebar/collections.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with TickerProviderStateMixin {
  late final TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> pages = const [
    Activity(),
    Collections(),
  ];

  final List<String> tabs = const [
    'Activity',
    'Collections',
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            children: [
              TabBar(
                onTap: (value) {
                  _pageController.jumpToPage(value);
                },
                controller: _tabController,
                tabs: tabs
                    .map(
                      (tab) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tab,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: pages.length,
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Wrap(
          alignment: WrapAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              splashRadius: 18,
              tooltip: 'Settings',
            ),
          ],
        ),
      ],
    );
  }
}
