import '../repositories/productrepo.dart';

class ProductUseCases {
  final ProductRepo productRepo;
  ProductUseCases(this.productRepo);
  Future<dynamic> fetchAllProducts() async {
    print('fetchAllProducts() called');
    dynamic response = await productRepo.fetchProducts();
    return response;
  }
}
