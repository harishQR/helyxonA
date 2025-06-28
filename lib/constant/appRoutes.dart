import 'package:get/get.dart';
import 'package:helyxon/views/screens/productpage.dart';

import '../views/screens/allcategory.dart';

class AppRoutes {
  static const Product_pg = "/Pdtpg";
  static const all_cat = "/allcategory";

  static final routes = [
    GetPage(name: all_cat, page: () => Allcategory()),
    GetPage(name: Product_pg, page: () => Productpage()),
  ];
}
