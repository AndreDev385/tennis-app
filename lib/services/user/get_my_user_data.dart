import 'dart:convert';

import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/utils.dart';

class GetUserDataResponse {
  final int statusCode;
  final String? message;
  final UserDto? user;

  const GetUserDataResponse({
    required this.statusCode,
    this.message,
    this.user,
  });
}

Future<Result<GetUserDataResponse>> getMyUserData() async {
  try {
    final response = await Api.get('users/me');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    StorageHandler st = await createStorageHandler();

    st.saveUser(response.body);

    final user = UserDto.fromJson(jsonDecode(response.body));

    return Result.ok(GetUserDataResponse(
      statusCode: response.statusCode,
      user: user,
    ));
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
