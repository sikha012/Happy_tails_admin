import 'package:dio/dio.dart';
import 'package:happy_admin/app/data/models/pet_category.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';

class PetCategoryService extends ApiProvider {
  PetCategoryService() : super();
  Future<PetCategory> createPetCategory(Map<String, dynamic> data) async {
    try {
      final response = await dioJson.post('/petCategory', data: data);
      return PetCategory.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 409) {
        return Future.error('Pet Category already exists!');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Bad Request');
      } else {
        return Future.error('Unknown Error: ${err.response?.data}');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<PetCategory> updatePetCategory(
      String id, Map<String, dynamic> data) async {
    try {
      final response = await dioJson.put('/petCategory/$id', data: data);
      return PetCategory.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error('Pet Category not found!');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Unknown Error: ${err.response?.data}');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<String> deletePetCategory(String id) async {
    try {
      final response = await dioJson.delete('/petCategory/$id');
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error('Pet Category not found!');
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
  Future<List<PetCategory>> getAllPetCategories() async {
    try {
      final response = await dioJson.get('/petCategory');
      return response.data
          .map<PetCategory>((json) => PetCategory.fromJson(json))
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
