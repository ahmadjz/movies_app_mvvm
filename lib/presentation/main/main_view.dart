import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_mvvm/app/resources/assets_manager.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/view/home_page_view.dart';
import 'package:movies_app_mvvm/presentation/main/pages/settings/settings_page.dart';
import 'package:movies_app_mvvm/presentation/main/pages/watch_list/view/watch_list_page_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePageView(),
    const WatchListPageView(),
    const SettingsPage(),
  ];

  final _title = AppStrings.moviesStore;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Theme.of(context).textTheme.titleSmall),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.white, spreadRadius: AppSize.s1)
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 0
                      ? ImageAssets.homeFilledIcon
                      : ImageAssets.homeOutlineIcon,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 1
                      ? ImageAssets.desktopFilledIcon
                      : ImageAssets.desktopOutlineIcon,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 2
                      ? ImageAssets.userFilledIcon
                      : ImageAssets.userOutlineIcon,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
