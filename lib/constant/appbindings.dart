import 'package:get/get.dart';

import '../controllers/productshowcontroller.dart';
import '../repositories/productrepo.dart';
import '../usecase/productshowusecase.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductRepo>(() => ProductRepo(), fenix: true);
    Get.lazyPut<ProductUseCases>(() => ProductUseCases(Get.find<ProductRepo>()), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(Get.find<ProductUseCases>()), fenix: true);
  }
}