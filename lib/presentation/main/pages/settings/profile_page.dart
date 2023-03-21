import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/app_preferences.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/routes_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.menuContext,
  });
  final BuildContext menuContext;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: Icon(
              Icons.logout,
              color: ColorManager.primaryColor,
            ),
            title: Text(AppStrings.logout,
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Icon(
              Icons.arrow_circle_right_outlined,
              color: ColorManager.primaryColor,
            ),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  _logout() {
    _appPreferences.logout();
    _appPreferences.removeWatchListData();
    Navigator.pushReplacementNamed(
      widget.menuContext,
      Routes.loginRoute,
    );
  }
}
