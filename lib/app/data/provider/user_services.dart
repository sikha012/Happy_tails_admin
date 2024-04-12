import 'package:dio/dio.dart';
import 'package:happy_admin/app/data/models/user_model.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';

class UserService extends ApiProvider {
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await dioJson.get('/users');
      return (response.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } on DioException catch (err) {
      return Future.error(
          'Error occurred while fetching users: ${err.message}');
    }
  }

  Future<List<UserModel>> getUsersByFilter(
      {String? userType, String? userName}) async {
    try {
      final Map<String, dynamic> filterData = {};
      if (userType != null) filterData['userType'] = userType;
      if (userName != null) filterData['userName'] = userName;

      final response = await dioJson.post('/users/filter', data: filterData);
      return (response.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } on DioException catch (err) {
      return Future.error(
          'Error occurred while fetching users with filters: ${err.message}');
    }
  }
}
