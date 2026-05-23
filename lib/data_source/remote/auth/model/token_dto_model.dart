import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_dto_model.freezed.dart';
part 'token_dto_model.g.dart';

@freezed
class TokenDtoModel with _$TokenDtoModel {
  const factory TokenDtoModel({
    required String access,
    required String refresh,
  }) = _TokenDtoModel;

  factory TokenDtoModel.fromJson(Map<String, dynamic> json) => _$TokenDtoModelFromJson(json);
}
