import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'constant/appRoutes.dart';
import 'constant/appbindings.dart';
import 'constant/text.dart';
import 'models/productsmodel.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('productsBox');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: TextConstants.appName,
          initialBinding: InitialBinding(),
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.all_cat,
        );
      },
    );
  }
}


