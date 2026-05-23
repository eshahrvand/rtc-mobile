import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../profile/model/user_profile_dto_model.dart';
import 'model/token_dto_model.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('accounts/otp/request')
  Future<void> requestOtp(@Body() Map<String, dynamic> body);

  @POST('accounts/otp/verify')
  Future<TokenDtoModel> verifyOtp(@Body() Map<String, dynamic> body);

  @POST('accounts/token/refresh')
  Future<TokenDtoModel> refreshToken(@Body() Map<String, dynamic> body);
}
