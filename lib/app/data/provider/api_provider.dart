import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happy_admin/app/data/models/pet_category.dart';
import 'package:happy_admin/app/data/models/product.dart';
import 'package:happy_admin/app/data/models/product_category.dart';
import 'package:happy_admin/app/data/models/seller.dart';
import 'package:happy_admin/app/data/models/token.dart';
import 'package:happy_admin/app/utils/constants.dart';

class ApiProvider {
  final Dio dioJson = Dio(
    BaseOptions(
      baseUrl: baseUrlLink,
      connectTimeout: const Duration(seconds: 7500),
      receiveTimeout: const Duration(seconds: 7500),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );
  final Dio dioMultipart = Dio(
    BaseOptions(
      baseUrl: baseUrlLink,
      connectTimeout: const Duration(seconds: 7500),
      receiveTimeout: const Duration(seconds: 7500),
      responseType: ResponseType.json,
      contentType: 'multipart/form-data',
    ),
  );

  Future<Token> login(Map<String, dynamic> map) async {
    try {
      final response = await dioJson.post('/login', data: map);

      return tokenFromJson(response.toString());
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        return Future.error('Email not found!');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Some error in the server');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await dioJson.get('/product');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<Product>((product) => Product.fromJson(product))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<PetCategory>> getAllPetCategories() async {
    try {
      final response = await dioJson.get('/petCategory');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<PetCategory>((petCategory) => PetCategory.fromJson(petCategory))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ProductCategory>> getAllProductCategories() async {
    try {
      final response = await dioJson.get('/productCategory');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<ProductCategory>(
              (productCategory) => ProductCategory.fromJson(productCategory))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Seller>> getAllSellers() async {
    try {
      final response = await dioJson.get('/productSeller');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<Seller>((seller) => Seller.fromJson(seller))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> uploadProduct({
    required String productName,
    required int price,
    required int stockQuantity,
    required String description,
    required String fileName,
    required Uint8List? imageBytes,
    required int petCategory,
    required int productCategory,
    required int seller,
  }) async {
    FormData formData = FormData.fromMap({
      "name": productName,
      "price": price,
      "stockQuantity": stockQuantity,
      "description": description,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
      "petCategoryId": petCategory,
      "productCategoryId": productCategory,
      "productSellerId": seller,
    });

    try {
      final response = await dioMultipart.post('/product', data: formData);
      debugPrint(response.toString());
      if (response.statusCode == 201) {
        return response.data['message'];
      }
      return response.data['message'];
    } on DioException catch (err) {
      debugPrint("DioException caught: ${err.response?.data}");
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Error code 400');
      } else {
        return Future.error('Error in the code: ${err.message}');
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
      return Future.error(e.toString());
    }
  }
  // if (response.statusCode == 201) {
  //   var result = response.data;
  //   debugPrint(result);
  //   if (result is Map<String, dynamic> &&
  //       result.containsKey('message') &&
  //       result['message'] is String) {
  //     debugPrint(result['message']);
  //     return result['message'];
  //   } else {
  //     return Future.error("Unexpected response format");
  //   }
  // } else {
  //   debugPrint("Image upload failed with status: ${response.statusCode}");
  //   return response.data['message'];
  // }

  Future<String> updateProduct({
    required int productId,
    required String productName,
    required int price,
    required int stockQuantity,
    required String description,
    String? previousFile,
    String? fileName,
    Uint8List? imageBytes,
    required int petCategory,
    required int productCategory,
    required int seller,
  }) async {
    FormData formData = FormData.fromMap({
      "name": productName,
      "price": price,
      "stockQuantity": stockQuantity,
      "description": description,
      "petCategoryId": petCategory,
      "productCategoryId": productCategory,
      "productSellerId": seller,
      "previousFile": previousFile,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
    });

    try {
      final response = await dioMultipart.put(
        '/product/$productId',
        data: formData,
      );
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return response.data['message'];
      }
      return response.data['message'];
    } on DioException catch (err) {
      debugPrint("DioException caught: ${err.response?.data}");
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Error code 400');
      } else {
        return Future.error('Error in the code: ${err.message}');
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
      return Future.error(e.toString());
    }
  }
}
