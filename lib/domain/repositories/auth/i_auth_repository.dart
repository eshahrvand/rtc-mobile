import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/auth/auth_token.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> requestOtp(String mobile);
  Future<Either<Failure, AuthToken>> verifyOtp(String mobile, String otp);
  Future<Either<Failure, AuthToken>> refreshToken(String refresh);
}
