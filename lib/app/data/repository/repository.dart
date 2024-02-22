import 'package:happy_admin/app/data/models/token.dart';
import 'package:happy_admin/app/data/provider/api_provider.dart';

class Repository {
  final ApiProvider apiProvider;
  Repository(this.apiProvider);

  Future<Token> login(Map<String, dynamic> map) => apiProvider.login(map);
}
