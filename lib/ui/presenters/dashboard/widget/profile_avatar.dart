import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import '../../media_picker/media_picker.dart';
import '../../workspace/bloc/workspace_cubit.dart';
import '../../workspace/bloc/workspace_state.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});
  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorkspaceCubit, WorkspaceState>(
    builder: (context, state) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: SizedBox(
        height: 96,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: state.avatarStatus == WorkspaceStatus.loading
                    ? null
                    : () => _pick(context),
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayPalette.shade50,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: AppColors.primaryShadow,
                  ),
                  child: ClipOval(
                    child: state.avatarPreview != null
                        ? Image.memory(state.avatarPreview!, fit: BoxFit.cover)
                        : RtcImage(
                            image:
                                state.avatar ??
                                'assets/images/workspace_user.svg',
                            width: 88,
                            height: 88,
                            boxFit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                tooltip: S.current.editProfilePhoto,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                onPressed: state.avatarStatus == WorkspaceStatus.loading
                    ? null
                    : () => _pick(context),
                icon: const RtcImage(
                  image: 'assets/images/workspace_edit.svg',
                  width: 24,
                  height: 24,
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  void _pick(BuildContext context) {
    final cubit = context.read<WorkspaceCubit>();
    cubit.beginAvatarSelection();
    MediaPickerBottomSheet.show(
          context,
          imagesOnly: true,
          showCameraOverlay: false,
        )
        .then<void>((items) {
          if (items == null || items.isEmpty || cubit.isClosed) {
            return Future<void>.value();
          }
          final item = items.first;
          return item.xFile.readAsBytes().then<void>((bytes) {
            if (!cubit.isClosed) {
              cubit.selectAvatar(item.xFile, bytes);
            }
          });
        })
        .catchError((Object error) {
          if (!cubit.isClosed) {
            cubit.reportAvatarError(error);
          }
        });
  }
}
