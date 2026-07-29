// Flutter / Dart port of the web client's error-message map.
// Mirror of `web/src/app/core/http/error-messages.ts`. Keep the two in sync and
// aligned with the contract in `docs/ERROR_CODES.md`.
//
// The backend sends a stable `error.code` plus optional `error.params`; the UI
// owns the wording and decides verbosity per code here — terse codes return a
// short generic line, detailed codes interpolate `params`. Never display the
// backend `error.detail` (English, for logs) to end users; unknown codes fall
// back to [genericFallback].
//
// `params` keys are read in snake_case, exactly as the backend sends them.
//
// Drop this file into the mobile app (e.g. lib/core/http/error_messages.dart)
// and call [resolveErrorMessage] from your HTTP error handler. No external
// packages required.

/// Shown when a code is missing or not in the map. Never leaks English `detail`.
const String genericFallback = 'خطایی رخ داد. لطفاً دوباره تلاش کنید';

const List<String> _faDigits = [
  '۰',
  '۱',
  '۲',
  '۳',
  '۴',
  '۵',
  '۶',
  '۷',
  '۸',
  '۹',
];

/// Group an integer/double with en-US style thousands separators (',') and a
/// '.' decimal point. Deterministic, no locale data needed.
String _enUsGroup(num value) {
  final bool isNegative = value < 0;
  final num abs = value.abs();

  String intPart;
  String fracPart = '';
  if (abs is int || abs == abs.roundToDouble()) {
    intPart = abs.toInt().toString();
  } else {
    final String s = abs.toString(); // e.g. "15.5"
    final int dot = s.indexOf('.');
    intPart = s.substring(0, dot);
    fracPart = s.substring(dot); // includes the leading '.'
  }

  final StringBuffer buf = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) buf.write(',');
    buf.write(intPart[i]);
  }
  return '${isNegative ? '-' : ''}$buf$fracPart';
}

/// Render a numeric param with Persian digits + separators (٬ thousands,
/// ٫ decimal), matching the web client output.
String _fa(dynamic value) {
  if (value == null) return '';
  final String text = value is num ? _enUsGroup(value) : value.toString();
  return text
      .replaceAllMapped(RegExp(r'\d'), (m) => _faDigits[int.parse(m[0]!)])
      .replaceAll(',', '٬')
      .replaceAll('.', '٫');
}

typedef _MessageFn = String Function(Map<String, dynamic>? params);

final Map<String, _MessageFn> _errorMessages = <String, _MessageFn>{
  // --- generic / framework ---
  'validation_error': (_) => 'اطلاعات واردشده معتبر نیست',
  'not_authenticated': (_) => 'برای ادامه باید وارد شوید',
  'permission_denied': (_) => 'دسترسی مجاز نیست',
  'not_found': (_) => 'مورد موردنظر یافت نشد',
  'method_not_allowed': (_) => 'این عملیات مجاز نیست',
  'rate_limited': (_) => 'درخواست‌های زیادی ارسال شد — لطفاً چند لحظه صبر کنید',
  'server_error': (_) => 'خطای سرور رخ داد — لطفاً بعداً دوباره تلاش کنید',
  'network_error': (_) =>
      'اتصال به سرور برقرار نشد — اینترنت یا آدرس سرور را بررسی کنید',

  // --- accounts / OTP ---
  'otp_expired': (_) => 'کد تأیید منقضی شده است — کد جدید دریافت کنید',
  'otp_invalid': (_) => 'کد تأیید واردشده نادرست است',
  'otp_rate_limited': (_) =>
      'درخواست‌های زیادی ارسال شد — لطفاً چند لحظه صبر کنید',
  'user_not_registered': (_) => 'این شماره موبایل در سامانه ثبت نشده است',

  // --- wallet ---
  'tolerance_exceeded': (p) =>
      'مغایرت مبلغ (${_fa(p?['variance'])}٪) از حد مجاز شما (${_fa(p?['tolerance'])}٪) بیشتر است',
  'credit_limit_exceeded': (p) =>
      'این برداشت از سقف اعتبار شما عبور می‌کند؛ مانده پس از برداشت ${_fa(p?['resulting_balance'])} ریال می‌شود',
  'insufficient_pocket_balance': (_) =>
      'موجودی کیف پول برای این عملیات کافی نیست',

  // --- orders ---
  'product_not_available_for_subplan': (_) =>
      'این کالا در طرح انتخاب‌شده قابل سفارش نیست',
  'insufficient_stock': (_) => 'موجودی کالا برای تعداد درخواستی کافی نیست',
  'illegal_state_transition': (_) =>
      'این عملیات در وضعیت فعلی سفارش امکان‌پذیر نیست',
  'order_immutable': (_) => 'این سفارش قابل تغییر نیست',
  'invalid_order_status': (_) => 'وضعیت سفارش اجازهٔ این عملیات را نمی‌دهد',
  'order_not_editable': (_) => 'سفارش فقط در وضعیت پیش‌فاکتور قابل ویرایش است',
  'order_total_limit_exceeded': (p) => p?['max_total'] != null
      ? 'مبلغ کل سفارش از حداکثر مجاز (${_fa(p?['max_total'])} ریال) بیشتر است'
      : 'مبلغ کل سفارش از حداکثر مجاز بیشتر است',
  'agent_required': (_) => 'انتخاب نماینده الزامی است',
  'pre_invoice_unavailable': (_) =>
      'پیش‌فاکتور فقط برای سفارش‌های در وضعیت پیش‌فاکتور در دسترس است',
  'sales_queue_empty': (_) => 'سفارش بررسی‌نشده‌ای در صف وجود ندارد',
  'not_assigned_sales_reviewer': (_) => 'این سفارش به شما ارجاع داده نشده است',
  'not_assigned_finance_reviewer': (_) =>
      'این سفارش به شما ارجاع داده نشده است',

  // --- gateway ---
  'gateway_invalid_otp': (_) => 'رمز پویا نادرست است — دوباره وارد کنید',
  'gateway_session_expired': (_) =>
      'نشست پرداخت منقضی شد — لطفاً از ابتدا اقدام کنید',
  'gateway_rejected': (_) => 'تراکنش از سوی بانک تأیید نشد',
  'gateway_unavailable': (_) =>
      'درگاه موقتاً در دسترس نیست — کمی بعد دوباره تلاش کنید',
  'gateway_misconfigured': (_) =>
      'درگاه پرداخت پیکربندی نشده است — با پشتیبانی تماس بگیرید',

  // --- plans ---
  'subplan_has_orders': (_) => 'این زیرطرح به دلیل داشتن سفارش قابل حذف نیست',
  'subplan_has_transactions': (_) =>
      'این زیرطرح به دلیل داشتن تراکنش مالی قابل حذف نیست',

  // --- catalog ---
  'category_has_products': (_) =>
      'این دسته‌بندی به دلیل داشتن کالا قابل حذف نیست',
  'product_not_orderable': (_) => 'این کالا در طرح انتخاب‌شده قابل سفارش نیست',

  // --- media ---
  'unsupported_file_type': (_) => 'نوع فایل انتخاب‌شده مجاز نیست',
  'file_too_large': (p) => p?['max_mb'] != null
      ? 'حجم فایل بیش از حد مجاز است (حداکثر ${_fa(p?['max_mb'])} مگابایت)'
      : 'حجم فایل بیش از حد مجاز است',
  'image_processing_failed': (_) =>
      'پردازش تصویر ممکن نشد — فایل دیگری را امتحان کنید',
  'file_processing_failed': (_) =>
      'پردازش فایل ممکن نشد — فایل دیگری را امتحان کنید',
};

/// Resolve a localized message for a backend error code, interpolating params.
/// Returns [genericFallback] for unknown/missing codes — never the raw English
/// `detail`.
String resolveErrorMessage(String? code, [Map<String, dynamic>? params]) {
  final _MessageFn? fn = code == null ? null : _errorMessages[code];
  if (fn != null) return fn(params);
  return genericFallback;
}

// ---------------------------------------------------------------------------
// Envelope parsing helper
// ---------------------------------------------------------------------------
//
// Every API error has the shape:
//   { "error": { "status_code": 422, "code": "tolerance_exceeded",
//                "params": { ... }, "detail": "English (logs only)" } }
//
// `detail` may be a String, or for 400 it is a field map: { "mobile": ["..."] }.

/// Parsed API error. `detail` is kept for logging only — show [message] instead.
class ApiError implements Exception {
  ApiError({
    required this.statusCode,
    required this.code,
    required this.params,
    this.detail,
    this.fieldErrors,
  });

  final int statusCode;
  final String code;
  final Map<String, dynamic> params;

  /// English text (logs/debugging). Do not display to users.
  final Object? detail;

  /// Present for 400 responses: { fieldName: [messages] }.
  final Map<String, List<String>>? fieldErrors;

  /// The localized, user-facing message.
  String get message => resolveErrorMessage(code, params);

  /// Build from a decoded JSON body + HTTP status. Falls back gracefully when
  /// the body is missing/not enveloped (e.g. transport errors → pass status 0).
  factory ApiError.fromResponse(int status, dynamic body) {
    final Map<String, dynamic>? envelope = (body is Map && body['error'] is Map)
        ? Map<String, dynamic>.from(body['error'])
        : null;

    final int statusCode = (envelope?['status_code'] as int?) ?? status;
    final String code =
        (envelope?['code'] as String?) ?? _fallbackCodeForStatus(status);
    final Map<String, dynamic> params = (envelope?['params'] is Map)
        ? Map<String, dynamic>.from(envelope!['params'])
        : {};
    final dynamic detail = envelope?['detail'];

    Map<String, List<String>>? fieldErrors;
    if (status == 400 && detail is Map) {
      fieldErrors = detail.map(
        (k, v) => MapEntry(
          k.toString(),
          (v as List).map((e) => e.toString()).toList(),
        ),
      );
    }

    return ApiError(
      statusCode: statusCode,
      code: code,
      params: params,
      detail: detail,
      fieldErrors: fieldErrors,
    );
  }
}

/// Fallback code for transport-level / non-enveloped responses (no `error.code`).
String _fallbackCodeForStatus(int status) {
  switch (status) {
    case 0:
      return 'network_error';
    case 401:
      return 'not_authenticated';
    case 403:
      return 'permission_denied';
    case 429:
      return 'rate_limited';
    case 502:
    case 503:
      return 'gateway_unavailable';
    default:
      return 'server_error';
  }
}
