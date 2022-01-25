import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/cart/viewModel.dart';
import 'package:grocery_app/widgets/chart_item_widget.dart';

import 'checkout_bottom_sheet.dart';
class CartScreen extends StatefulWidget {
  //const CartScreen({ key }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartViewModel cartvm = CartViewModel();
  Future cart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cart=cartvm.getCartItems();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: cart,
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator(backgroundColor: Colors.green,color:Colors.white)));
              }
             if(cartvm.cartItems.length==0){
               return Container(
                 height: MediaQuery.of(context).size.height,
                 child: Center(
                   child:Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text('Sorry!!'),
                       Text('No items in Cart. Please add items to cart!')
                     ],
                   )
                 ),
               );
             }
              return Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "My Cart",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: getChildrenWithSeperator(
                      addToLastChild: false,
                      widgets: cartvm.cartItems.map((e) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          width: double.maxFinite,
                          child: ChartItemWidget(
                            item: e,
                          ),
                        );
                      }).toList(),
                      seperator: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: ()async{
                      //await cartvm.checkout();
                    },
                    child: getCheckoutButton(context,cartvm))
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context,cartvm) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        label: "Go To Check Out",
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(vertical: 30),
        onPressed: () {
          showBottomSheet(context,cartvm);
        },
      ),
    );
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "\$12.96",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context,cartvm) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet(cartvm);
        }).then((value)async{
          await cartvm.getCartItems();
          setState(() {
            
          });
        });
  }

}

class CartScreen2 extends StatelessWidget {
  CartViewModel cartvm =CartViewModel();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "My Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: getChildrenWithSeperator(
                  addToLastChild: false,
                  widgets: demoItems.map((e) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      width: double.maxFinite,
                      child: ChartItemWidget(
                        item: e,
                      ),
                    );
                  }).toList(),
                  seperator: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              getCheckoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        label: "Go To Check Out",
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(vertical: 30),
        trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "\$12.96",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet(cartvm);
        });
  }
}
