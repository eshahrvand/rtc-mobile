import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/data_source/remote/workspace/workspace_service.dart';
import 'package:rtc_mobile/repository/workspace/workspace_mapper.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_state.dart';
import 'contracts_test.dart' show LocalAdapter;

Map<String, dynamic> slide(int position, String action, {String? url}) => {
  'id': 'slide-$position',
  'position': position,
  'image': {
    'file': 'https://images.test/$position.png',
    'width': 662,
    'height': 391,
  },
  'action_type': action,
  'action_screen': 'orders',
  'action_url': url,
};

void main() {
  test('active slider maps sorted images and explicit action types', () {
    final banners = WorkspaceMapper.slider({
      'title': 'تبلیغات',
      'slides': [
        slide(3, 'none', url: 'https://ignored.test'),
        slide(2, 'url', url: 'https://caltivita.ir'),
        slide(1, 'screen'),
        slide(4, 'url', url: 'javascript:alert(1)'),
        slide(5, 'unknown', url: 'https://ignored.test'),
      ],
    });
    expect(banners.map((b) => b.id), [
      'slide-1',
      'slide-2',
      'slide-3',
      'slide-4',
      'slide-5',
    ]);
    expect(banners.first.imageWidth, 662);
    expect(banners.first.height, 391);
    expect(banners.first.screen, 'orders');
    expect(banners.first.link, isNull);
    expect(banners[1].link.toString(), 'https://caltivita.ir');
    expect(banners[1].screen, isNull);
    for (final banner in banners.skip(2)) {
      expect(banner.link, isNull);
      expect(banner.screen, isNull);
    }
  });

  test('empty slider and unusable images map to no section', () {
    for (final data in <Map<String, dynamic>?>[
      null,
      {},
      {'slides': []},
      {
        'slides': [slide(1, 'none')..['image'] = null],
      },
      {
        'slides': [
          slide(1, 'none')
            ..['image'] = {'file': '', 'width': 662, 'height': 391},
        ],
      },
      {
        'slides': [
          slide(1, 'none')
            ..['image'] = {'file': 'image.png', 'width': 0, 'height': 391},
        ],
      },
    ]) {
      expect(WorkspaceMapper.slider(data), isEmpty);
    }
  });

  for (final status in [200, 204, 404]) {
    test(
      'active slider empty response $status clears existing banners',
      () async {
        final adapter = LocalAdapter(
          (_) => (status, status == 200 ? {'slides': []} : null),
        );
        final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/api/v1/'))
          ..httpClientAdapter = adapter;
        addTearDown(dio.close);
        final cubit = WorkspaceCubit(
          WorkspaceRepository.remote(WorkspaceService(dio)),
        );
        addTearDown(cubit.close);
        final updated = cubit.stream.first;
        cubit.loadHomeBanners();
        await updated;
        expect(cubit.state.banners, isEmpty);
        expect(adapter.requests.single.path, 'content/sliders/active');
        expect(adapter.requests.single.method, 'GET');
      },
    );
  }

  test('remote slider loads for both roles', () async {
    for (final role in AccountRole.values) {
      final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/'))
        ..httpClientAdapter = LocalAdapter(
          (_) => (
            200,
            {
              'slides': [slide(1, 'screen')],
            },
          ),
        );
      addTearDown(dio.close);
      final cubit = WorkspaceCubit(
        WorkspaceRepository.remote(WorkspaceService(dio)),
        initialState: WorkspaceState(
          banners: WorkspaceMapper.slider({
            'slides': [slide(1, 'none')],
          }),
        ),
      );
      addTearDown(cubit.close);
      cubit.setProfile(null, role: role);
      final updated = cubit.stream.firstWhere((s) => s.banners.isNotEmpty);
      cubit.loadHomeBanners();
      await updated;
      expect(cubit.state.banners.single.screen, 'orders');
    }
  });

  test(
    'late older slider response does not replace the latest empty result',
    () async {
      final old = Completer<List<HomeBanner>>();
      var calls = 0;
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          loadBanners: () => ++calls == 1 ? old.future : Future.value([]),
        ),
      );
      addTearDown(cubit.close);
      cubit.loadHomeBanners();
      cubit.loadHomeBanners();
      await Future<void>.delayed(Duration.zero);
      old.complete(
        WorkspaceMapper.slider({
          'slides': [slide(1, 'none')],
        }),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.banners, isEmpty);
    },
  );
}
