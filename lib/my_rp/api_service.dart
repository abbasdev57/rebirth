//  to make api calls to the backend or interact with the database
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:rebirth/my_rp/user_modal.dart';

class ApiServices {
  String baseUrl = "https://reqres.in/api/users?page=1";

 Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      return data.map(((e) => UserModel.fromJson(e))).toList();
      //   alternate
    } else {
      throw Exception('Failto load users');
    }
  }
}

final userProvider = Provider<ApiServices>((ref) => ApiServices());
