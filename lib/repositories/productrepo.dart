import 'package:dio/dio.dart';
import 'package:helyxon/constant/apiendpoints.dart';

class ProductRepo {
  final Dio client = Dio();
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    const String url = ApiUrls.productsapi;
    try {
      Response response = await client.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        throw Exception("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}