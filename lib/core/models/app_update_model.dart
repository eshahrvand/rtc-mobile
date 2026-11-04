import 'package:flutter/foundation.dart';

@immutable
class AppUpdateModel {
  const AppUpdateModel({
    required this.version,
    this.isForce = false,
    this.updateAvailable = true,
    this.buildNumber,
    this.changeLog,
    this.downloadUrl,
    this.fileSize,
    this.sha256,
    this.title,
    this.releaseDate,
    this.extraData,
  });

  /// The target version name (e.g. "1.0.0")
  final String version;

  /// Whether the user must install the update before continuing
  final bool isForce;

  /// Whether a newer build is available according to the server
  final bool updateAvailable;

  /// Target build number (e.g. 39)
  final int? buildNumber;

  /// Release notes / changes
  final String? changeLog;

  /// Direct download URL or store link
  final String? downloadUrl;

  /// File size in bytes
  final int? fileSize;

  /// SHA256 checksum
  final String? sha256;

  /// Custom sheet title
  final String? title;

  /// Release timestamp
  final String? releaseDate;

  /// Full raw JSON response for future extension
  final Map<String, dynamic>? extraData;

  /// Displays "نسخه X.Y.Z" or "نسخه X.Y.Z (build N)"
  String get displayVersion {
    if (version.isNotEmpty) return version;
    if (buildNumber != null) return 'Build $buildNumber';
    return '';
  }

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) {
    final latest = json['latest'] is Map
        ? Map<String, dynamic>.from(json['latest'] as Map)
        : null;

    final updateAvailable =
        json['update_available'] as bool? ?? (latest != null);

    final force = json['force_update'] == true ||
        latest?['is_mandatory'] == true ||
        json['is_force'] == true ||
        json['update_force'] == true ||
        json['is_mandatory'] == true;

    final versionStr = latest?['version_name']?.toString() ??
        json['version_name']?.toString() ??
        latest?['version']?.toString() ??
        json['version']?.toString() ??
        '';

    final buildNum = (latest?['build_number'] as num?)?.toInt() ??
        (json['build_number'] as num?)?.toInt();

    final rawChanges = latest?['changelog'] ??
        latest?['change_log'] ??
        json['changelog'] ??
        json['change_log'] ??
        json['description'] ??
        latest?['description'];

    String? changes;
    if (rawChanges is List) {
      changes = rawChanges.map((e) => e.toString()).join('\n');
    } else if (rawChanges is String) {
      changes = rawChanges;
    }

    final url = latest?['download_url'] as String? ??
        json['download_url'] as String? ??
        latest?['url'] as String? ??
        json['url'] as String? ??
        json['link'] as String?;

    final fileSize = (latest?['file_size'] as num?)?.toInt() ??
        (json['file_size'] as num?)?.toInt();

    final sha256 = latest?['sha256'] as String? ?? json['sha256'] as String?;

    final publishedAt = latest?['published_at'] as String? ??
        json['published_at'] as String? ??
        latest?['publish_date'] as String? ??
        json['publish_date'] as String?;

    final title = json['title'] as String? ?? latest?['title'] as String?;

    return AppUpdateModel(
      version: versionStr,
      isForce: force,
      updateAvailable: updateAvailable,
      buildNumber: buildNum,
      changeLog: changes,
      downloadUrl: url,
      fileSize: fileSize,
      sha256: sha256,
      title: title,
      releaseDate: publishedAt,
      extraData: json,
    );
  }

  Map<String, dynamic> toJson() => {
        'update_available': updateAvailable,
        'force_update': isForce,
        'latest': {
          'version_name': version,
          if (buildNumber != null) 'build_number': buildNumber,
          'is_mandatory': isForce,
          if (downloadUrl != null) 'download_url': downloadUrl,
          if (fileSize != null) 'file_size': fileSize,
          if (sha256 != null) 'sha256': sha256,
          if (changeLog != null) 'changelog': changeLog,
          if (releaseDate != null) 'published_at': releaseDate,
        },
        if (extraData != null) ...extraData!,
      };

  AppUpdateModel copyWith({
    String? version,
    bool? isForce,
    bool? updateAvailable,
    int? buildNumber,
    String? changeLog,
    String? downloadUrl,
    int? fileSize,
    String? sha256,
    String? title,
    String? releaseDate,
    Map<String, dynamic>? extraData,
  }) {
    return AppUpdateModel(
      version: version ?? this.version,
      isForce: isForce ?? this.isForce,
      updateAvailable: updateAvailable ?? this.updateAvailable,
      buildNumber: buildNumber ?? this.buildNumber,
      changeLog: changeLog ?? this.changeLog,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      fileSize: fileSize ?? this.fileSize,
      sha256: sha256 ?? this.sha256,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      extraData: extraData ?? this.extraData,
    );
  }
}
