import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aeqarat/src/utils/networking/authentication_api.dart';

class NotificationsScreen extends StatefulWidget{
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();

}

class _NotificationsScreenState extends State<NotificationsScreen>{
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationApi>(
      builder: (context, authenticationApi, child) {
        return Scaffold();
      }
    );
  }

}