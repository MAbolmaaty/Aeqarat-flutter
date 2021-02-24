import 'package:aeqarat/src/screens/home_screen.dart';
import 'package:aeqarat/src/screens/login_screen.dart';
import 'package:aeqarat/src/screens/notifications_screen.dart';
import 'package:aeqarat/src/screens/profile_screen.dart';
import 'package:aeqarat/src/screens/real_estates_screen.dart';
import 'package:aeqarat/src/screens/settings_screen.dart';
import 'package:aeqarat/src/utils/networking/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavScreen extends StatefulWidget {
  final int index;
  final bool visible;

  BottomNavScreen(this.index, this.visible);

  static Route<dynamic> route(int index, bool visible) => MaterialPageRoute(
        builder: (context) => BottomNavScreen(index, visible),
      );

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState(index, visible);
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int index;
  bool visible;

  _BottomNavScreenState(this.index, this.visible);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthenticationApi(),
        child: Consumer<AuthenticationApi>(
            builder: (context, authenticationApi, child) {
              if(authenticationApi.authenticationStatus == Authentication.Unauthenticated){
                SharedPreferences.getInstance().then((instance) {
                  String apiToken = instance.getString('api_token');
                  if(apiToken != null){
                    authenticationApi.profile(apiToken);
                  }
                });
              }
          return Scaffold(
              body: IndexedStack(
                index: index,
                children: [
                  NotificationsScreen(),
                  authenticationApi.authenticationStatus ==
                          Authentication.Authenticated
                      ? ProfileScreen()
                      : LoginScreen(),
                  HomeScreen(),
                  RealEstatesScreen(),
                  SettingsScreen(),
                ],
              ),
              bottomNavigationBar: Visibility(
                visible: visible,
                child: BottomNavigationBar(
                  currentIndex: index,
                  selectedItemColor: const Color(0xFFFFDB27),
                  unselectedItemColor: const Color(0xFFCCCCCC),
                  onTap: (int index) {
                    setState(() {
                      index = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications_none),
                        label: AppLocalizations.of(context).notifications),
                    BottomNavigationBarItem(
                        icon: authenticationApi.authenticationStatus ==
                                Authentication.Authenticated
                            ? Icon(Icons.person_outline)
                            : Icon(Icons.login),
                        label: authenticationApi.authenticationStatus ==
                                Authentication.Authenticated
                            ? AppLocalizations.of(context).profile
                            : AppLocalizations.of(context).login),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: AppLocalizations.of(context).home),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_work_outlined),
                        label: AppLocalizations.of(context).realStates),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: AppLocalizations.of(context).settings),
                  ],
                ),
              ));
        }));
  }
}
