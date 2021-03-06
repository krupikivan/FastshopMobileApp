import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get promoCant {
    return _prefs.getInt('promo') ?? 0;
  }

  set promoCant(int value) {
    _prefs.setInt('promo', value);
  }
}
