import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happy_admin/app/data/models/order_detail_model.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';

class OrderService extends ApiProvider {
  Future<List<OrderDetailModel>> getOrdersToDeliver() async {
    try {
      String endpoint = '/orderdetails/deliver';
      final response = await dioJson.get(endpoint);
      debugPrint(response.data.toString());

      List<OrderDetailModel> orders = (response.data as List)
          .map((orderDetailModelJson) =>
              OrderDetailModel.fromJson(orderDetailModelJson))
          .toList();
      return orders;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error("Orders Details not found");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching products: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception("Exception: ${e.toString()}");
    }
  }

  Future<List<OrderDetailModel>> getOrdersToDeliverByUserId(int userId) async {
    try {
      String endpoint = '/orderdetails/seller/$userId';
      final response = await dioJson.get(endpoint);
      debugPrint(response.data.toString());

      List<OrderDetailModel> orders = (response.data as List)
          .map((orderDetailModelJson) =>
              OrderDetailModel.fromJson(orderDetailModelJson))
          .toList();
      return orders;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error(
              "Orders Details not found for Seller ID: $userId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching products: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception("Exception: ${e.toString()}");
    }
  }

  Future<String> updateOrderDeliveryStatus({
    required int orderDetailId,
    required String status,
    required String userFCM,
    required String productName,
  }) async {
    try {
      final response = await dioJson.put(
        '/orderdetails/update',
        data: jsonEncode({
          "orderDetailId": orderDetailId,
          "status": status,
          "userFCM": userFCM,
          "productName": productName,
        }),
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
