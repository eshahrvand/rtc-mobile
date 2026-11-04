import 'package:flutter/foundation.dart';

enum AccountRole { agent, employee }

@immutable
class TermsDocument {
  const TermsDocument({
    this.id,
    required this.version,
    required this.versionLabel,
    required this.markdown,
    required this.publishedAt,
    this.acceptedAt,
    this.downloadUrl,
  });
  final String? id;
  final String version;
  final String versionLabel;
  final String markdown;
  final String publishedAt;
  final String? acceptedAt;
  final Uri? downloadUrl;
}

@immutable
class HomeBanner {
  const HomeBanner({
    required this.id,
    required this.image,
    required this.height,
    this.imageWidth,
    this.link,
    this.screen,
    this.description = '',
    this.imageAlignmentX = 0,
    this.imageScale = 1,
  });
  final String id;
  final String image;
  final double height;
  final double? imageWidth;
  final Uri? link;
  final String? screen;
  final String description;
  final double imageAlignmentX;
  final double imageScale;
}

@immutable
class BranchInfo {
  const BranchInfo({
    required this.id,
    required this.name,
    required this.province,
    required this.city,
    required this.postalCode,
    required this.address,
    this.isActive = true,
  });
  final String id, name, province, city, postalCode, address;
  final bool isActive;
}

@immutable
class BranchEmployee {
  const BranchEmployee({
    required this.id,
    required this.branchId,
    required this.firstName,
    required this.lastName,
    required this.nationalId,
    required this.mobile,
    required this.position,
    this.isActive = true,
    this.avatar,
  });
  final String id, branchId, firstName, lastName, nationalId, mobile, position;
  final bool isActive;
  final String? avatar;
  String get fullName => '$firstName $lastName'.trim();
}

/// UI draft retained until the delivery API contract is supplied.
@immutable
class DeliveryRecipient {
  const DeliveryRecipient({required this.fullName, required this.nationalId});
  final String fullName, nationalId;
}
