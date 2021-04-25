import 'package:fastshop_mobile/application.dart';
import 'package:fastshop_mobile/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferences();
  await prefs.initPrefs();
  SharedPreferences.getInstance().then((instance) {
    String token =
        instance.getString('token') == null ? "" : instance.getString('token');
    runApp(Application(
      token: token,
    ));
  });
}
