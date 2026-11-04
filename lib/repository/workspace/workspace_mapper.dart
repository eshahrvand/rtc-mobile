import '../../core/models/workspace_models.dart';
import '../../core/utils/date_time_utils.dart';
import '../../generated/l10n.dart';

class WorkspaceMapper {
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

  static Map<String, String> get positions => {
    'store_user': S.current.storeUserPosition,
    'store_accountant': S.current.shopAccountant,
    'store_manager': S.current.shopSupervisor,
  };
  static BranchEmployee employee(Map<String, dynamic> json) => BranchEmployee(
    id: json['id'] as String,
    branchId: (json['store'] as Map)['id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    nationalId: json['national_code'] as String? ?? '',
    mobile: json['mobile'] as String,
    position: positions[json['position']] ?? json['position'] as String? ?? '',
    isActive: json['is_active'] as bool,
    avatar: (json['avatar'] as Map?)?['file'] as String?,
  );
  static Map<String, dynamic> employeeBody(BranchEmployee employee) {
    final code = positions.entries
        .where(
          (item) =>
              item.value == employee.position || item.key == employee.position,
        )
        .firstOrNull
        ?.key;
    if (code == null)
      throw const FormatException('Unknown sales-person position');
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
