import 'package:grocery_app/constants/urls.dart';
import 'package:grocery_app/screens/account/models.dart';
import 'package:grocery_app/utils/requests.dart';

class AccountViewModel{
  User user;
  bool error;

  Future<void> getUserInfo()async{
    final response=await getRequest(USERINFO);
    this.error=!response['success'];
    if(response['success']){
      print(response['data']);
      this.user=User.fromJson(response);
      print(this.user.name);
    }
  }

}