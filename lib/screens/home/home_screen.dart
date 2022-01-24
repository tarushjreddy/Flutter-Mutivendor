import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/home/home_feed_modal.dart';
import 'package:grocery_app/screens/location/map.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SvgPicture.asset("assets/icons/app_icon_color.svg"),
                  SizedBox(
                    height: 5,
                  ),
                  padded(GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen()))
                            .then((value) {
                          setState() {
                            _address = value;
                          }
                        });
                      },
                      child: locationWidget())),
                  SizedBox(
                    height: 15,
                  ),
                  padded(SearchBarWidget()),
                  SizedBox(
                    height: 25,
                  ),
                  padded(HomeBanner()),
                  SizedBox(
                    height: 25,
                  ),
                  getHorizontalItemSlider(exclusiveOffers),
                  SizedBox(
                    height: 15,
                  ),
                  getHorizontalItemSlider(bestSelling),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 105,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[0],
                          color: Color(0xffF8A44C),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[1],
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  getHorizontalItemSlider(groceries),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<GroceryItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onItemClicked(context, items[index]);
                  },
                  child: GroceryItemCardWidget(
                    item: snapshot.data[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
            );
          }),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(groceryItem)),
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Khartoum,Sudan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
