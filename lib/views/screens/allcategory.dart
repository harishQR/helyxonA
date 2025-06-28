import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helyxon/constant/appRoutes.dart';
import 'package:helyxon/constant/text.dart';
import 'package:helyxon/widgets/common_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/productshowcontroller.dart';
class Allcategory extends StatefulWidget {
  const Allcategory({super.key});

  @override
  State<Allcategory> createState() => _AllcategoryState();
}

class _AllcategoryState extends State<Allcategory> {
  final ProductController prdttctr = Get.find();

  @override
  void initState() {
    super.initState();
    prdttctr.fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
           GestureDetector(
             onTap: (){
               FocusScope.of(context).unfocus();
             },
             child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color:Color(0xffD9D9D9),
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding:  EdgeInsets.only(top: 7.5.h,),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 0.5.h, left: 0.2.w, right: 0.2.w),
                            height: 100.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                            ),
                            child: Obx(() {
                              if (prdttctr.isLoading.value) {
                                return ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 10.h,
                                          width: 20.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: prdttctr.categoryList.length,
                                  padding: EdgeInsets.only(bottom: 15.h, top: 0.5.h),
                                  itemBuilder: (BuildContext context, int index) {
                                    final category = prdttctr.categoryList[index];
                                    return Obx(() {
                                      final isSelected = prdttctr.selectedCategory.value == category;
                                      return GestureDetector(
                                        onTap: () => prdttctr.filterProductsByCategory(category),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(2.w),
                                              width: 20.w,
                                              height: 10.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: isSelected ? Colors.pink : Colors.grey,
                                                  width: isSelected ? 2 : 1,
                                                ),
                                              ),
                                              child: Center(
                                                child: Image.network(
                                                  prdttctr.categoryImages[category] ??
                                                      'https://via.placeholder.com/100',
                                                  width: 10.w,
                                                  height: 7.h,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            titleSmall(
                                              category.capitalizeFirst ?? "",
                                              14.sp,
                                              TextAlign.center,
                                              isSelected ? Colors.pink : Colors.black,
                                              FontWeight.bold,
                                              maxLines: 3,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                );
                              }
                            }),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 1.w),
                                height: 6.h,
                                width: 75.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  cursorHeight: 2.5.h,
                                  onChanged: (value) {
                                    prdttctr.updateSearchQuery(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                                    hintText: "Search Category",
                                    hintStyle: TextStyle(fontSize: 18.sp, color: Colors.grey),
                                    suffixIcon: Icon(Icons.search, color: Colors.black),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(fontSize: 18.sp, decoration: TextDecoration.none,),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 1.w,top:0.5.h),
                                padding: EdgeInsets.all(3.w),
                                height: 93.h,
                                width: 76.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Obx(
                                        ()=> Row(
                                        children: [
                                          titleSmall("${prdttctr.filteredProductList.length}", 16.sp, TextAlign.start, Colors.green, FontWeight.bold),
                                          titleSmall(" items in", 16.sp, TextAlign.start, Colors.black, FontWeight.bold),
                                          titleSmall(" ${prdttctr.selectedCategory.value}", 16.sp, TextAlign.start, Colors.pink, FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.black.withOpacity(0.4),),
                                    Obx(() {
                                      if (prdttctr.isLoading.value) {
                                        return Expanded(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.green,
                                              strokeWidth: 4,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Expanded(
                                          child: GridView.builder(
                                            padding: EdgeInsets.only(bottom: 14.h),
                                            shrinkWrap: true,
                                            itemCount: prdttctr.filteredProductList.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 2.h,
                                              crossAxisSpacing: 2.w,
                                              childAspectRatio: 0.60,
                                            ),
                                            itemBuilder: (context, index) {
                                              final product = prdttctr.filteredProductList[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context).unfocus();
                                                  Get.toNamed(AppRoutes.Product_pg, arguments: product);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey.shade400),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(top: 0.8.h),
                                                            width: 30.w,
                                                            height: 12.h,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Image.network(
                                                              product.image,
                                                              width: 30.w,
                                                              height: 12.h,
                                                              fit: BoxFit.contain,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 1.3.h,
                                                            right: 3.w,
                                                            child: Icon(
                                                              CupertinoIcons.heart_fill,
                                                              color: Colors.red,
                                                              size: 6.w,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 2.w, right: 0.5.w, top: 0.5.h),
                                                            child: titleSmall(
                                                              TextConstants.currency + product.price.toStringAsFixed(2),
                                                              15.sp,
                                                              TextAlign.start,
                                                              Colors.black,
                                                              FontWeight.bold,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                                        child: Divider(color: Colors.grey.shade400),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 0.1.h),
                                                        child: titleSmall(
                                                          product.title,
                                                          14.sp,
                                                          TextAlign.start,
                                                          Colors.black,
                                                          FontWeight.bold,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(left: 2.w, top: 0.3.h),
                                                            width: 14.w,
                                                            height: 2.8.h,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.pink,
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Icon(CupertinoIcons.star_fill,
                                                                      color: Colors.yellow, size: 3.w),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 1.w),
                                                                    child: titleSmall(
                                                                      product.rating.toString(),
                                                                      14.sp,
                                                                      TextAlign.start,
                                                                      Colors.yellow,
                                                                      FontWeight.bold,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                       ),
           ),
            Positioned(
                top:0,
                left: 0,
                right: 0,
                child:
             appbar(context, title: "All Categories",showBackIcon: false, showMenuIcon: true,onMenuTap: (){}),
            ),
      ],
        ),
      ),
    );
  }
}
