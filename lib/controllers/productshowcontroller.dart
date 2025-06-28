import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/productsmodel.dart';
import '../usecase/productshowusecase.dart';

class ProductController extends GetxController {
  final ProductUseCases usecase;
  ProductController(this.usecase);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxString selectedCategory = ''.obs;
  RxString searchQuery = ''.obs;
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProductsByCategory(selectedCategory.value);
  }
  RxList<ProductModel> filteredProductList = <ProductModel>[].obs;
  final Map<String, String> categoryImages = {
    "men's clothing": 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
    "women's clothing": 'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
    "jewelery": 'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    "electronics": 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
  };
  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';
    final productBox = Hive.box<ProductModel>('productsBox');
    try {
      final result = await usecase.fetchAllProducts();

      if (result is List) {
        final products = result.map((item) => ProductModel.fromJson(item)).toList();
        productList.value = products;
        extractCategories();
        // Save to Hive
        await productBox.clear(); // optional: clear old cache
        for (var product in products) {
          await productBox.put(product.id, product);
        }
      } else {
        errorMessage.value = 'Unexpected data format';
      }
    } catch (e) {
      errorMessage.value = 'Offline mode: loading cached data';
      final cachedProducts = productBox.values.toList();
      if (cachedProducts.isNotEmpty) {
        productList.value = cachedProducts;
        extractCategories();
      }
    } finally {
      isLoading.value = false;
    }
  }


  // Extract unique categories from products :
  void extractCategories() {
    final uniqueCategories = productList.map((e) => e.category).toSet().toList();
    categoryList.value = uniqueCategories;
    print('Extracted categories: $uniqueCategories');
    if (uniqueCategories.isNotEmpty) {
      // Set first category as selected by default :
      selectedCategory.value = uniqueCategories.first;
      filterProductsByCategory(uniqueCategories.first);
    }
  }

  // Filter products by category
  void filterProductsByCategory(String category) {
    selectedCategory.value = category.trim().toLowerCase();
    final filtered = productList.where((product) {
      final matchesCategory = product.category.trim().toLowerCase() == selectedCategory.value;
      final matchesSearch = product.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    filteredProductList.value = filtered;
  }
}
