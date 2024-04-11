import 'package:dio/dio.dart';
import 'package:happy_admin/app/data/models/product_category.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';

class ProductCategoryServices extends ApiProvider {
  ProductCategoryServices() : super();

  Future<ProductCategory> createProductCategory(
      Map<String, dynamic> data) async {
    try {
      final response = await dioJson.post('/productCategory', data: data);
      return ProductCategory.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 409) {
        return Future.error('Product Category already exists!');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Bad Request');
      } else {
        return Future.error('Unknown Error: ${err.response?.data}');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<ProductCategory> updateProductCategory(
      String id, Map<String, dynamic> data) async {
    try {
      final response = await dioJson.put('/productCategory/$id', data: data);
      return ProductCategory.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error('Product Category not found!');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Unknown Error: ${err.response?.data}');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<String> deleteProductCategory(String id) async {
    try {
      final response = await dioJson.delete('/productCategory/$id');
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error('Product Category not found!');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Unknown Error: ${err.response?.data}');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  @override
  Future<List<ProductCategory>> getAllProductCategories() async {
    try {
      final response = await dioJson.get('/productCategory');
      return response.data
          .map<ProductCategory>((json) => ProductCategory.fromJson(json))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error: ${err.response?.data}');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }
}
