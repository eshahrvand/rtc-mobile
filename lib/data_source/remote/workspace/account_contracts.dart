import 'package:flutter/foundation.dart';

@immutable
class PolicyStatusDto {
  const PolicyStatusDto({
    required this.required,
    this.version,
    this.acceptedVersion,
    this.acceptedAt,
  });
  final bool required;
  final int? version, acceptedVersion;
  final String? acceptedAt;
  factory PolicyStatusDto.fromJson(Map<String, dynamic> json) =>
      PolicyStatusDto(
        required: json['required'] as bool,
        version: (json['version'] as num?)?.toInt(),
        acceptedVersion: (json['accepted_version'] as num?)?.toInt(),
        acceptedAt: json['accepted_at'] as String?,
      );
  Map<String, dynamic> toJson() => {
    'required': required,
    'version': version,
    'accepted_version': acceptedVersion,
    'accepted_at': acceptedAt,
  };
}

@immutable
class StoreReferenceDto {
  const StoreReferenceDto({
    required this.id,
    required this.name,
    this.isActive,
  });
  final String id, name;
  final bool? isActive;
  factory StoreReferenceDto.fromJson(Map<String, dynamic> json) =>
      StoreReferenceDto(
        id: json['id'] as String,
        name: json['name'] as String,
        isActive: json['is_active'] as bool?,
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (isActive != null) 'is_active': isActive,
  };
}

@immutable
class OrderCreatorDto {
  const OrderCreatorDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
  });
  final String id, firstName, lastName, role;
  factory OrderCreatorDto.fromJson(Map<String, dynamic> json) =>
      OrderCreatorDto(
        id: json['id'] as String,
        firstName: json['first_name'] as String? ?? '',
        lastName: json['last_name'] as String? ?? '',
        role: json['role'] as String,
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'role': role,
  };
}

@immutable
class ProfileDocumentDto {
  const ProfileDocumentDto({
    required this.id,
    required this.file,
    this.uploadedById,
    this.createdAt,
  });
  final String id;
  final Map<String, dynamic> file;
  final String? uploadedById, createdAt;
  factory ProfileDocumentDto.fromJson(Map<String, dynamic> json) =>
      ProfileDocumentDto(
        id: json['id'] as String,
        file: Map.unmodifiable(json['file'] as Map<String, dynamic>),
        uploadedById: json['uploaded_by_id'] as String?,
        createdAt: json['created_at'] as String?,
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'file': file,
    'uploaded_by_id': uploadedById,
    'created_at': createdAt,
  };
}
