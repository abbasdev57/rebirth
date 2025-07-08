import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/my_rp/api_service.dart';
import 'package:rebirth/my_rp/user_modal.dart';

final userDataProvider = FutureProvider<List<UserModel>>((ref) async{
  return ref.watch(userProvider).getUsers();

});
