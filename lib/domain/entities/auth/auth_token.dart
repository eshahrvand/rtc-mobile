import 'package:equatable/immutable.dart';
import 'package:meta/meta.dart';

@immutable
class AuthToken {
  final String access;
  final String refresh;

  const AuthToken({
    required this.access,
    required this.refresh,
  });
}
