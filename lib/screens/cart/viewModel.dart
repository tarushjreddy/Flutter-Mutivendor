import 'dart:convert';

import 'package:grocery_app/constants/urls.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/utils/requests.dart';

class CartViewModel{
  List<GroceryItem>  cartItems=[];
  bool response;
  Map<String,dynamic> _initialdata;

  Future<void> getCartItems()async{
    final response=await getRequest(CART);
    print(response);
    this.response=response['success'];
    if(response['success']){
      try{this._initialdata=response;}catch(e){print(e);}
      try{
        print(response['items'][0]['qty'].toDouble().runtimeType);
        response['items'].forEach((e){
        var item=new GroceryItem(
          name: e['name'],
          id: e['_id'],
          price: e['price'].toDouble(),
          qty: e['qty'].toDouble(),
          vendorId: e['vendorid'],
          imagePath: e['imgurl']
        );
        cartItems.add(item);
      });
      }catch(err){
        print(err);
      }
    }
    print(cartItems);
  }

  Future<void> removeCart(GroceryItem item,double qty)async{
    this.response=true;
    final data={'items':{'name':item.name,'_id':item.id,'price':item.price,'qty':qty}};
    final response=await postRequest(data, CARTREM);
    this.response=response['success'];
  }

  Future addToCart(GroceryItem item,double qty)async{
    this.response=false;
    print('executing');
    final response= await postRequest({"items":{'_id':item.id,'qty':qty,'name':item.name,'price':item.price,'vendorid':item.vendorId}}, CARTADD);
    this.response=response['success'];
    print(this.response);
  }

  Future checkout()async{
    var listofcart=[];
    this.cartItems.forEach((e){
      var temp;
      temp= e.toJson();
      listofcart.add(temp);
    });
    var sendData=_initialdata;
    sendData['items']=listofcart;
    await postRequest(sendData, CHECKOUT);
  }
  

}