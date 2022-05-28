import 'package:flutter/material.dart';
import 'package:global_conference/models/cart_item.dart';

class AppColors {
  static const primary = Color(0xff01569e);
  static const grey = Color(0xff2c3941);
  static const lightgrey = Color(0xffeef2f5);
  static const orange = Color(0xfff65446);
}

class AppFonts {
  static const headline1 = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
  );

  static const headline2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
}

Map<String, CartItem> _appProducts = {
  'tshirt1': const CartItem(
      code: 'tshirt1',
      name: 'T-shirt',
      price: 25.50,
      type: CartItemType.gift,
      qty: 2),
  'cap1': const CartItem(
    code: 'cap1',
    name: 'Baseball cap',
    price: 10.99,
    type: CartItemType.gift,
  ),
  'event1': const CartItem(
    code: 'event1',
    name: 'Starting with Flutter',
    price: 55.00,
    type: CartItemType.event,
  ),
};

CartItem getAppProduct(String key) {
  if (_appProducts.containsKey(key)) {
    return _appProducts[key]!;
  } else {
    return const CartItem(
      code: 'error',
      name: 'Error',
      price: 999999999999,
      type: CartItemType.event,
    );
  }
}

const String agoriaAppId = "abcde";
const String agoriaToken = "abcde";
