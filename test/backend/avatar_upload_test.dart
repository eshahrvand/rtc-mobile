import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/data_source/remote/workspace/workspace_service.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_state.dart';
import 'contracts_test.dart' show LocalAdapter;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => S.load(const Locale('fa')));

  for (final role in AccountRole.values) {
    test(
      'avatar upload uses media/images user_avatar multipart for ${role.name}',
      () async {
        final adapter = LocalAdapter(
          (_) => (
            201,
            {
              'id': 'image-id',
              'image_group': 'user_avatar',
              'title': 'portrait.jpg',
              'file': 'https://images.test/avatar.jpg',
              'width': 128,
              'height': 128,
              'file_size': 4,
              'uploaded_by_id': 'me',
              'created_at': '2026-11-04T12:33:23Z',
            },
          ),
        );
        final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/api/v1/'))
          ..httpClientAdapter = adapter;
        addTearDown(dio.close);
        final cubit = WorkspaceCubit(
          WorkspaceRepository.remote(WorkspaceService(dio)),
          initialState: WorkspaceState(role: role),
        );
        addTearDown(cubit.close);
        final bytes = Uint8List.fromList([255, 216, 255, 217]);
        final file = XFile.fromData(
          bytes,
          name: 'portrait.jpg',
          mimeType: 'image/jpeg',
        );
        final finished = cubit.stream.firstWhere(
          (state) =>
              state.avatarStatus == WorkspaceStatus.success ||
              state.avatarStatus == WorkspaceStatus.error,
        );
        cubit.selectAvatar(file, bytes);
        expect(cubit.state.avatarStatus, WorkspaceStatus.loading);
        await finished;
        expect(cubit.state.avatarStatus, WorkspaceStatus.success);
        expect(cubit.state.avatar, 'https://images.test/avatar.jpg');
        expect(adapter.requests, hasLength(1));
        final request = adapter.requests.single;
        expect(request.path, 'media/images');
        expect(request.method, 'POST');
        final form = request.data as FormData;
        expect(Map.fromEntries(form.fields)['image_group'], 'user_avatar');
        expect(form.files.single.key, 'file');
        expect(form.files.single.value.filename, endsWith('.jpg'));
        expect(form.files.single.value.length, bytes.length);
      },
    );
  }

  test('failed avatar upload does not report successful persistence', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/'))
      ..httpClientAdapter = LocalAdapter(
        (_) => (
          400,
          {
            'error': {'code': 'unsupported_file_type'},
          },
        ),
      );
    addTearDown(dio.close);
    final cubit = WorkspaceCubit(
      WorkspaceRepository.remote(WorkspaceService(dio)),
    );
    addTearDown(cubit.close);
    final bytes = Uint8List.fromList([1, 2]);
    final finished = cubit.stream.firstWhere(
      (state) => state.avatarStatus == WorkspaceStatus.error,
    );
    cubit.selectAvatar(XFile.fromData(bytes, name: 'portrait.jpg'), bytes);
    await finished;
    expect(cubit.state.avatarStatus, WorkspaceStatus.error);
    expect(cubit.state.avatar, isNull);
    expect(cubit.state.errorMessage, isNotEmpty);
  });
}
