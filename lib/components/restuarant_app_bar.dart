import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maleda/pages/cartPage.dart';
import 'package:maleda/routes/routed.dart';
import 'package:maleda/widgets/app_icon.dart';
import 'package:get/get.dart';

class RestaurantAppBAr extends StatelessWidget {
  RestaurantAppBAr({
    super.key,
  });
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.orange,
      pinned: true,
      expandedHeight: 340,
      backgroundColor: Colors.orange,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          "assets/images/Header-image.png",
          fit: BoxFit.cover,
        ),
      ),

      // leading: Padding(
      //   padding: EdgeInsets.only(left: 16),
      //   child: Icon(Icons.menu),
      // ),
      actions: [
        GestureDetector(
          onTap: () async {
            FlutterSecureStorage storage = const FlutterSecureStorage();
            var value = [];
            total = 0;
            var jsonString = await storage.read(key: "carts");

            if (jsonString != null) {
              var jsonDecoded = json.decode(jsonString);

              value = jsonDecoded;

              for (var data in jsonDecoded) {
                int q = data['quantity'];
                int pr = data['price'];
                int sub = (q * pr);
                print(sub);
                total += sub;
              }
              print(total);
            }

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CartPage(carts: value, total: total),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}