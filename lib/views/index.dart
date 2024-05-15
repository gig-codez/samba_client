// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentVersion = '';
  String _latestVersion = '';
  Future<void> _checkForUpdates() async {
    // Retrieve the current version of the app
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _currentVersion = packageInfo.version;
    });
    // log("Current Version: $_currentVersion");
    // Make an API call to get the latest version from the server
    String latestVersion = await UpdateService.getVersion();

    // Compare versions and prompt for an update if necessary
    if (latestVersion.isNotEmpty) {
      if (_currentVersion != latestVersion) {
        if (mounted) {
          setState(() {
            _latestVersion = latestVersion;
          });
          showUpdateDialog(
              latestVersion: _latestVersion, version: _currentVersion);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  // selected nav item
  int selected = 0;

  final String ext = "assets/bottom_navs/";
  List<Map<String, dynamic>> bottomNavs = [
    {"label": "Home", "icon": "home.svg", "un": "home_un.svg"},
    {"label": "News", "icon": "livescore.svg", "un": "livescore_un.svg"},
    {"label": "Stats", "icon": "stats.svg", "un": "stats_un.svg"},
    {"label": "Logs", "icon": "page.svg", "un": "page_un.svg"},
    {"label": "Profile", "icon": "profile.svg", "un": "profile_un.svg"},
  ];
  // page controller
  final PageController pageController = PageController();

  // pages to render
  List<Widget> pages = [
    const HomePage(),
    const NewsPage(),
    const StatsPage(),
     TransfersPage(),
    const GeneralSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        controller: pageController,
        itemBuilder: (context, page) => pages[page],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selected = index;
          });
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 700),
            curve: Curves.ease,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        selectedIconTheme: const IconThemeData(size: 30),
        currentIndex: selected,
        items: List.generate(
          bottomNavs.length,
          (index) => BottomNavigationBarItem(
            label: bottomNavs[index]['label'],
            icon: SvgPicture.asset(
              "$ext${selected == index ? bottomNavs[index]['icon'] : bottomNavs[index]['un']}",
              color: selected == index ? primaryColor : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
