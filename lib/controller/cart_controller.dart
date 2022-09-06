import 'dart:math';

import 'package:e_menu/main.dart';
import 'package:e_menu/model/menu_model.dart';
import 'package:e_menu/model/rate_food_list.dart';
import 'package:e_menu/model/recent_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/final_list.dart';
import 'home_controller.dart';

class CartController extends GetxController {






  List<MenuModel> menuCart = []; //list in cart
  List<FinalList> finalList = []; //list for send it to backend
  List<RateFoodList> rateList= []; //list for customer to rate their food
  double totalPrice = 0.0;
  double remainingTime = 0.0;
  RxDouble sliderValue=0.0.obs;

  var detailsContent = TextEditingController();
  bool usePointsFlag=false;
  int? usePoint;

  String? nameOfGift;
  String? imageOfGift;
  bool? gift;
  int sale=0;

  RxBool isLoading=false.obs;

  HomeController homeController=Get.find();

  void add(MenuModel item) //add to cart
  {
        menuCart.add(item); //add item to list in cart
        finalList.add(FinalList(id: item.id,qty: 1,message: "none")); //add id of item and empty message and qty=1 to final list to send it to database
        rateList.add(RateFoodList(id: item.id,rate: 0,name: item.name)); //add id & name item for rate

        if (item.status == "offer") {
          totalPrice += double.parse(item.priceSale.toString());
        }
        else {
          totalPrice += double.parse(item.price.toString());
        }
    update();
  }

   void addFromRecent(RecentListMoudel item)
   {
     menuCart.add(MenuModel(id: item.productId,name: item.product!.name,price: item.product!.price,priceSale: item.product!.priceSale,image: item.product!.image,status: item.product!.status));
     finalList.add(FinalList(id: item.productId,qty: item.qtu,message: "none"));
     rateList.add(RateFoodList(id: item.productId,rate: 0,name: item.product!.name)); //add id & name item for rate
     if (item.product!.status == "offer") {
       totalPrice += double.parse(item.product!.priceSale.toString())*item.qtu!.toInt();
     }
     else {
       totalPrice += double.parse(item.product!.price.toString())*item.qtu!.toInt();
     }
     update();
   }

  void clearBasket() {
    menuCart.clear();
    totalPrice = 0;
    update();
  }

  int get count //number of item in cart
  {
    return menuCart.length;
  }

  double get price //total price of cart
  {
    return totalPrice;
  }

  List <MenuModel> get basket //cart
  {
    return menuCart;
  }

  void deleteItemFromCart(MenuModel item, int? qty) //remove item from cart
  {
    menuCart.remove(item);
    if (item.status == "offer") {
      totalPrice -= (double.parse(item.priceSale.toString()) *
          qty!); //when remove item from cart => total price decrease price of item * qty of item
    }
    else {
      totalPrice -= (double.parse(item.price.toString()) * qty!); //when remove item from cart => total price decrease price of item * qty of item
    }

    update();
  }

  // void deleteItemFromCart(MenuModel item,int? qty) //remove item from cart
  // {
  //   menuCart.remove(item);
  //   totalPrice -= (double.parse(item.price.toString())* qty!); //when remove item from cart => total price decrease price of item * qty of item
  //   update();
  // }

  void incrementQty(MenuModel item) //add price of item to total price when increase its qty
  {
    if (item.status == "offer") {
      totalPrice += double.parse(item.priceSale.toString());
    }
    else {
      totalPrice += double.parse(item.price.toString());
    }

    update();
  }

  // void incrementQty(MenuModel item) //add price of item to total price when increase its qty
  // {
  //   totalPrice+= double.parse(item.price.toString());
  //   update();
  // }

  void decrementQty(MenuModel item) //remove price of item from total price when decrease its qty
  {
    if (item.status == "offer") {
      totalPrice -= double.parse(item.priceSale.toString());
    }
    else {
      totalPrice -= double.parse(item.price.toString());
    }
    update();
  }

// void decrementQty(MenuModel item) //remove price of item from total price when decrease its qty
// {
//   totalPrice-= double.parse(item.price.toString());
//   update();
// }

void useDiscount()
{

  sale=totalPrice.toInt();
  sale-=usePoint! *5000;
  //homeController.customerPoints.value= homeController.customerPoints.value! - usePoint!;
  usePointsFlag=true;
  sliderValue.value=0.0;
  update();
}

void setState()
{
  update();
}

// void search (String query)
// {
//   final suggestion = basket.where((element) {
//     final itemName =element.name!.toLowerCase();
//     final input = query.toLowerCase();
//
//     return itemName.contains(input);
//   }).toList();
//
//   menuCart = suggestion;
// }




}