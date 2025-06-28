import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/text.dart';
import '../../controllers/productshowcontroller.dart';
import '../../models/productsmodel.dart';
import '../../widgets/common_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Productpage extends StatefulWidget {
  const Productpage({super.key});

  @override
  State<Productpage> createState() => _ProductpageState();
}
class _ProductpageState extends State<Productpage>  with WidgetsBindingObserver{
  late final ProductModel product;
  final ProductController prdttctr = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    product = Get.arguments as ProductModel;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).unfocus();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void deactivate() {
    FocusScope.of(context).unfocus();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color:Color(0xffD9D9D9),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(top: 7.h,bottom: 8.h),
                  child: Column(
                    children: [
                      Obx( () {
                        if (prdttctr.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors
                                  .green,
                              strokeWidth: 4,
                            ),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.only(top: 0.3.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10)),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0.8.h),
                                      width: 70.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: product.image,
                                        width: 70.w,
                                        height: 25.h,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 70.w,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                    Positioned(
                                        top: 1.3.h,
                                        right: 3.w,
                                        child: Icon(CupertinoIcons.heart_fill,
                                          color: Colors.red, size: 8.w,))
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.h, left: 4.w),
                                  child: Row(
                                    children: [
                                      titleSmall(TextConstants.currency +
                                          product.price.toStringAsFixed(2),
                                          18.sp, TextAlign.start,
                                          Colors.black,
                                          FontWeight.bold, maxLines: 2),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.w),
                                        child: titleSmall(
                                            "upto 50% off", 16.sp,
                                            TextAlign.start, Colors.grey,
                                            FontWeight.bold, maxLines: 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 3.w, right: 3.w),
                                  child: Divider(
                                    color: Colors.grey.shade400,),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 3.w, right: 0.5.w, top: 1.h),
                                  child: titleSmall(
                                      product.title, 18.sp, TextAlign.start,
                                      Colors.black, FontWeight.bold,
                                      maxLines: 2),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 2.w, top: 1.h),
                                      padding: EdgeInsets.only(right: 1.w),
                                      width: 22.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10),
                                        color: Colors.pink,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(CupertinoIcons.star_fill,
                                              color: Colors.yellow,
                                              size: 5.w,),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 1.w),
                                              child: titleSmall(
                                                  product.rating.toString(),
                                                  17.sp, TextAlign.start,
                                                  Colors.yellow,
                                                  FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.w, top: 1.h),
                                      child: titleSmall("Description:", 16.sp,
                                          TextAlign.start, Colors.black,
                                          FontWeight.bold, maxLines: 2),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.w, top: 1.h),
                                      child: Container(
                                          width: 85.w,
                                          child: titleSmall(
                                              product.description, 14.sp,
                                              TextAlign.start, Colors.black,
                                              FontWeight.normal,
                                              maxLines: 500)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.w, top: 1.h),
                                      child: titleSmall(
                                          "Reviews:", 16.sp, TextAlign.start,
                                          Colors.black, FontWeight.bold,
                                          maxLines: 2),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.w, top: 1.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.4),
                                              blurRadius: 6,
                                              spreadRadius: 1,
                                              offset: Offset(0,
                                                  3),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 5.w,
                                          backgroundColor: Colors.white,
                                          child: titleSmall(
                                            product.ratingCount.toString(),
                                            16.sp,
                                            TextAlign.start,
                                            Colors.green,
                                            FontWeight.bold,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 2.w, top: 1.h),
                                      child: titleSmall(
                                        "peoples Reviewed this product !",
                                        16.sp,
                                        TextAlign.start,
                                        Colors.black,
                                        FontWeight.bold,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              titleSmall("⭐️⭐️⭐️⭐️⭐️", 16.sp,
                                                  TextAlign.start,
                                                  Colors.orange,
                                                  FontWeight.bold),
                                              SizedBox(height: 0.5.h),
                                              titleSmall(
                                                  "Very comfortable and stylish. Fits perfectly!",
                                                  15.sp, TextAlign.start,
                                                  Colors.black,
                                                  FontWeight.normal),
                                              SizedBox(height: 0.3.h),
                                              Text(
                                                  "- Rahul", style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              titleSmall("⭐️⭐️⭐️⭐️", 16.sp,
                                                  TextAlign.start,
                                                  Colors.orange,
                                                  FontWeight.bold),
                                              SizedBox(height: 0.5.h),
                                              titleSmall(
                                                  "Good quality but delivery was late",
                                                  16.sp, TextAlign.start,
                                                  Colors.black,
                                                  FontWeight.normal),
                                              SizedBox(height: 0.3.h),
                                              Text(
                                                  "- Sneha", style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              titleSmall("⭐️⭐️⭐️", 16.sp,
                                                  TextAlign.start,
                                                  Colors.orange,
                                                  FontWeight.bold),
                                              SizedBox(height: 0.5.h),
                                              titleSmall(
                                                  "Decent for the price, but the fit could be better",
                                                  16.sp, TextAlign.start,
                                                  Colors.black,
                                                  FontWeight.normal),
                                              SizedBox(height: 0.3.h),
                                              Text(
                                                  "- Arjun", style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top:0,
              left: 0,
              right: 0,
              child:
              appbar(context, title: "Product Page",showBackIcon: true, showMenuIcon: false,),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 8.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, -3),
                        blurRadius: 2,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                        child: Center(child: titleSmall("Add to Cart",18.sp, TextAlign.center, Colors.black, FontWeight.bold)),
                      ),
                      Container(
                        width: 50.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                        ),
                     child:   Center(child: titleSmall("Buy Now",18.sp, TextAlign.center, Colors.black, FontWeight.bold)),
                      ),
                    ],
                  ),
                ), )
          ],
        ),
      ),
    );
  }
}
