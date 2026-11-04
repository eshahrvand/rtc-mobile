import '../../core/models/workspace_models.dart';
import '../../core/utils/date_time_utils.dart';
import '../../generated/l10n.dart';

class WorkspaceMapper {
  static List<HomeBanner> slider(Map<String, dynamic>? json) {
    final slides = json?['slides'];
    if (slides is! List || slides.isEmpty) return [];
    final sorted = slides.whereType<Map>().toList()
      ..sort(
        (a, b) => ((a['position'] as num?) ?? 0).compareTo(
          (b['position'] as num?) ?? 0,
        ),
      );
    return sorted
        .map((slide) {
          final image = slide['image'];
          if (image is! Map) return null;
          final file = image['file'];
          final width = image['width'];
          final height = image['height'];
          if (file is! String ||
              file.trim().isEmpty ||
              width is! num ||
              height is! num ||
              !width.isFinite ||
              !height.isFinite ||
              width <= 0 ||
              height <= 0) {
            return null;
          }
          final action = slide['action_type'];
          final rawUrl = slide['action_url'];
          final uri = action == 'url' && rawUrl is String
              ? Uri.tryParse(rawUrl)
              : null;
          return HomeBanner(
            id: slide['id'] as String,
            image: file,
            height: height.toDouble(),
            imageWidth: width.toDouble(),
            description: json?['title'] as String? ?? '',
            link:
                uri != null &&
                    const {'http', 'https'}.contains(uri.scheme) &&
                    uri.host.isNotEmpty
                ? uri
                : null,
            screen: action == 'screen'
                ? slide['action_screen'] as String?
                : null,
          );
        })
        .whereType<HomeBanner>()
        .toList();
  }

  static TermsDocument policy(Map<String, dynamic> json) {
    final clauses = json['clauses'];
    final String markdown;
    if (clauses is List) {
      markdown = clauses
          .map((clause) {
            final item = Map<String, dynamic>.from(clause as Map);
            final title = item['title'] as String? ?? '';
            return '${title.isEmpty ? '' : '## $title\n\n'}${item['body'] as String}';
          })
          .join('\n\n');
    } else if (clauses is String) {
      markdown = clauses; // Swagger currently also documents this shape.
    } else {
      throw const FormatException('Invalid privacy-policy clauses');
    }
    final publishedAt = json['published_at'] as String;
    final date = DateTimeUtils.formatToJalaliDate(publishedAt);
    final version = (json['version'] as num).toInt().toString();
    return TermsDocument(
      id: json['id'] as String,
      version: version,
      versionLabel: S.current.policyVersionLabel(version, date),
      markdown: markdown,
      publishedAt: DateTimeUtils.formatToJalaliDate(publishedAt),
      acceptedAt: json['accepted_at'] == null
          ? null
          : DateTimeUtils.formatToJalaliDate(json['accepted_at'] as String),
    );
  }

  static BranchInfo branch(Map<String, dynamic> json) => BranchInfo(
    id: json['id'] as String,
    name: json['name'] as String,
    province: (json['province'] as Map?)?['name'] as String? ?? '',
    city: (json['city'] as Map?)?['name'] as String? ?? '',
    postalCode: json['postal_code'] as String? ?? '',
    address: json['address'] as String? ?? '',
    isActive: json['is_active'] as bool,
  );

  static Map<String, String> get positions {
    final userPos = S.current.storeUserPosition.isNotEmpty
        ? S.current.storeUserPosition
        : 'فروشنده';
    final accountantPos = S.current.shopAccountant.isNotEmpty
        ? S.current.shopAccountant
        : 'حسابدار فروشگاه';
    final managerPos = S.current.shopSupervisor.isNotEmpty
        ? S.current.shopSupervisor
        : 'مدیر فروشگاه';
    return {
      'store_user': userPos,
      'store_accountant': accountantPos,
      'store_manager': managerPos,
    };
  }

  static String resolvePosition(String? codeOrTitle, {String fallback = ''}) {
    if (codeOrTitle == null || codeOrTitle.trim().isEmpty) return fallback;
    final trimmed = codeOrTitle.trim();
    if (positions.containsKey(trimmed)) {
      return positions[trimmed]!;
    }
    return switch (trimmed) {
      'store_user' || 'فروشنده' || 'کارمند فروشگاه' =>
        positions['store_user'] ?? 'فروشنده',
      'store_accountant' || 'حسابدار فروشگاه' =>
        positions['store_accountant'] ?? 'حسابدار فروشگاه',
      'store_manager' || 'مدیر فروشگاه' || 'سرپرست فروشگاه' =>
        positions['store_manager'] ?? 'مدیر فروشگاه',
      _ => trimmed.isNotEmpty ? trimmed : fallback,
    };
  }

  static BranchEmployee employee(Map<String, dynamic> json) => BranchEmployee(
    id: json['id'] as String,
    branchId: (json['store'] as Map)['id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    nationalId: json['national_code'] as String? ?? '',
    mobile: json['mobile'] as String,
    position: resolvePosition(json['position'] as String?),
    isActive: json['is_active'] as bool,
    avatar: (json['avatar'] as Map?)?['file'] as String?,
  );

  static Map<String, dynamic> employeeBody(BranchEmployee employee) {
    var code = positions.entries
        .where(
          (item) =>
              item.value == employee.position || item.key == employee.position,
        )
        .firstOrNull
        ?.key;
    code ??= switch (employee.position) {
      'فروشنده' || 'کارمند فروشگاه' || 'کارمند' => 'store_user',
      'حسابدار فروشگاه' => 'store_accountant',
      'مدیر فروشگاه' || 'سرپرست فروشگاه' => 'store_manager',
      _ => null,
    };
    if (code == null) {
      throw const FormatException('Unknown sales-person position');
    }
    return {
      'mobile': employee.mobile,
      'first_name': employee.firstName,
      'last_name': employee.lastName,
      'is_active': employee.isActive,
      'store': employee.branchId,
      'national_code': employee.nationalId,
      'position': code,
    };
  }
}
