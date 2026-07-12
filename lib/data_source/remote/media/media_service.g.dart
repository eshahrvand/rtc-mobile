// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _MediaService implements MediaService {
  _MediaService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<MediaDtoModel> uploadMedia({
    required String category,
    required File file,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('category', category));

    // Handle MultipartFile vs File safely for Web
    // If the file is actually a MultipartFile passed as dynamic, or we create it here
    // But since the signature is File, we must be careful.
    // In our Repository, we will handle the conversion.
    
    // NOTE: This generated file is manually patched to avoid Platform.pathSeparator
    _data.files.add(
      MapEntry(
        'file',
        await _createMultipartFile(file),
      ),
    );

    final _options = _setStreamType<MediaDtoModel>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            'media/files',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late MediaDtoModel _value;
    try {
      _value = MediaDtoModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  Future<MultipartFile> _createMultipartFile(File file) async {
    // Standard path extraction without Platform.pathSeparator
    String filename = file.path.split('/').last;
    if (filename.contains('\\')) {
      filename = filename.split('\\').last;
    }

    // On Web, File(path) doesn't work for reading, so the Repository 
    // should ideally pass a MultipartFile. But since we are restricted 
    // by the 'File' type in the interface, we'll assume mobile usage 
    // for this specific method, or handle it via bytes if possible.
    
    // However, for the 'uploadOrderDocumentWeb' flow, we call this 
    // but we need a way to pass the bytes.
    
    // If we are on Web, and this is called, it will likely fail if we try to read.
    // That's why we have uploadOrderDocumentWeb in the Repository.
    
    return MultipartFile.fromFileSync(
      file.path,
      filename: filename,
    );
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
