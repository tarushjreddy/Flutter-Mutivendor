import 'package:grocery_app/constants/urls.dart';
import 'package:grocery_app/utils/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninViewModel {
  bool success;
  String error;

  Future<void> signIn(Map<String, dynamic> data) async {
    Map<String, dynamic> response = await postRequest(data, SIGNIN);
    if (response['success'] == false) {
      this.success = false;
      this.error = response['error'];
    } else {
      bool session = await this._storeSession(response['token']);

      this.success = true;
    }
  }

  Future<bool> _storeSession(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool result = await _prefs.setString('token', token);
  }
}
