import 'package:grocery_app/constants/urls.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/utils/requests.dart';

class HomeViewModel{
  List<GroceryItem> groceries=[];
  bool result;

  Future<void> getItems()async{
    final response=await getRequest(ITEMS);
    if(response['success']){
      response['items'].forEach((item){
        try{
          print('item');
        var grocery=new GroceryItem(
          id:item['_id'],
          name: item['name'],
          price: item['price'].toDouble(),
          imagePath: item['imgurl'],
          vendorId: item['vendorid']
        );
        print(grocery.vendorId);
        this.groceries.add(grocery);
        }catch(err){
          print(err);
        }
      });
    }
  print(this.groceries);
  }

  Future addToCart(GroceryItem item,double qty)async{
    this.result=false;
    print('executing${item.imagePath}');
    final itemdata={'imgurl':item.imagePath,'_id':item.id,'qty':qty,'name':item.name,'price':item.price,'vendorid':item.vendorId};
    final response= await postRequest({"items":itemdata}, CARTADD);
    this.result=response['success'];
    print(this.result);
  }
  
}