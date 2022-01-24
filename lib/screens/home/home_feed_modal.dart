import 'package:grocery_app/constants/urls.dart';
import 'package:grocery_app/utils/requests.dart';

Future<List> getData() async {
  Map<String, dynamic> response = await getHomeData(SIGNIN);
  print(response);
  return response;
}
