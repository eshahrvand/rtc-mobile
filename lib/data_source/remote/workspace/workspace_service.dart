import 'package:dio/dio.dart';
import '../profile/model/user_profile_dto_model.dart';

/// These contracts are supplied separately from the legacy Retrofit clients.
class WorkspaceService {
  WorkspaceService(this.dio);
  final Dio dio;

  Future<Map<String, dynamic>?> activeSlider() => dio
      .get<dynamic>('content/sliders/active')
      .then<Map<String, dynamic>?>((response) {
        final data = response.data;
        if (data == null || data == '') return null;
        return Map<String, dynamic>.from(data as Map);
      })
      .catchError((Object error) {
        if (error is DioException && error.response?.statusCode == 404) {
          return null;
        }
        throw error;
      });

  Future<UserProfileDtoModel> getMe() => dio
      .get<Map<String, dynamic>>('accounts/me')
      .then((response) => UserProfileDtoModel.fromJson(response.data!));

  Future<Map<String, dynamic>?> currentPolicy() => dio
      .get<Map<String, dynamic>>('content/privacy-policies/current')
      .then<Map<String, dynamic>?>((response) => response.data!)
      .catchError((Object error) {
        if (error is DioException && error.response?.statusCode == 404)
          return null;
        throw error;
      });

  Future<Map<String, dynamic>> acceptPolicy(int version) => dio
      .post<Map<String, dynamic>>(
        'content/privacy-policies/current/accept',
        data: {'version': version},
      )
      .then((response) => response.data!);

  Future<String> policyHtml(String id) => dio
      .get<String>(
        'content/privacy-policies/${Uri.encodeComponent(id)}/document',
        options: Options(responseType: ResponseType.plain),
      )
      .then((response) => response.data!);

  Future<List<Map<String, dynamic>>> stores({String? search}) => _all(
    'accounts/stores',
    {if (search != null && search.trim().isNotEmpty) 'search': search.trim()},
  );
  Future<Map<String, dynamic>> store(String id) => dio
      .get<Map<String, dynamic>>('accounts/stores/${Uri.encodeComponent(id)}')
      .then((response) => response.data!);
  Future<List<Map<String, dynamic>>> employees(String storeId) =>
      _all('accounts/sales-persons', {'store': storeId});
  Future<Map<String, dynamic>> employee(String id) => dio
      .get<Map<String, dynamic>>(
        'accounts/sales-persons/${Uri.encodeComponent(id)}',
      )
      .then((response) => response.data!);
  Future<Map<String, dynamic>> saveEmployee(
    String id,
    Map<String, dynamic> body,
  ) =>
      (id.isEmpty
              ? dio.post<Map<String, dynamic>>(
                  'accounts/sales-persons',
                  data: body,
                )
              : dio.patch<Map<String, dynamic>>(
                  'accounts/sales-persons/${Uri.encodeComponent(id)}',
                  data: body,
                ))
          .then((response) => response.data!);
  Future<void> deleteEmployee(String id) => dio
      .delete<void>('accounts/sales-persons/${Uri.encodeComponent(id)}')
      .then((_) {});

  /// Never follow a response URL with authentication headers. Read its page
  /// number and keep using the configured API origin and original filters.
  Future<List<Map<String, dynamic>>> _all(
    String path,
    Map<String, dynamic> filters, {
    int page = 1,
    List<Map<String, dynamic>> items = const [],
    Set<int> seen = const {},
  }) {
    if (seen.contains(page))
      return Future.error(const FormatException('Repeated pagination page'));
    return dio
        .get<Map<String, dynamic>>(
          path,
          queryParameters: {...filters, 'page': page, 'page_size': 100},
        )
        .then((response) {
          final data = response.data!;
          final collected = [
            ...items,
            ...(data['results'] as List).map(
              (item) => Map<String, dynamic>.from(item as Map),
            ),
          ];
          final next = data['next'] as String?;
          if (next == null) return collected;
          final nextPage =
              int.tryParse(Uri.parse(next).queryParameters['page'] ?? '') ??
              page + 1;
          return _all(
            path,
            filters,
            page: nextPage,
            items: collected,
            seen: {...seen, page},
          );
        });
  }
}
