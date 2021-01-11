import 'package:aeqarat/src/screens/advanced_settings_screen.dart';
import 'package:aeqarat/src/screens/documents_screen.dart';
import 'package:aeqarat/src/screens/payment_methods_screen.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: Material(
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: const Color(0xFFFFDB27),
                  indicatorColor: const Color(0xFFFFDB27),
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(context).documents,
                    ),
                    Tab(
                      text: AppLocalizations.of(context).payment,
                    ),
                    Tab(
                      text: AppLocalizations.of(context).advanced,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: <Widget>[
                DocumentsScreen(),
                PaymentMethodsScreen(),
                AdvancedSettingsScreen()
              ],
            ))
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          ScreenAppBar(
            screenTitle: AppLocalizations.of(context).settings,
            implyLeading: false,
          )
        ],
      ),
    );
  }
}
