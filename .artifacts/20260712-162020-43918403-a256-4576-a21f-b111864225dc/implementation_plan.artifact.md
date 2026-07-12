# Implementation Plan - Media Picker / Repository / Service Cleanup

Cleanup and refactor of media-related code to remove debug artifacts, reduce duplication, and improve readability without changing behavior.

## Proposed Changes

### Media Picker Component
- Remove all `print` statements used for debugging lifecycle and permissions.
- Clean up unused imports (`dart:io` in some files).
- Standardize on `XFile` usage.

#### [media_picker_cubit.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/media_picker/bloc/media_picker_cubit.dart)
- Remove `print` statements in `loadInitialGallery`, `loadNextPage`, `captureFromCamera`, `pickFromGalleryWeb`, and `pickFile`.
- Remove unused import `dart:io`.
- Keep PhotoManager permission handling logic as is, just remove the prints.

#### [media_edit_screen.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/media_picker/widget/media_edit_screen.dart)
- Remove unused import `dart:io`.

---

### Media Data Layer
- Consolidate `kIsWeb` branching in `MediaService.uploadMedia`.
- Extract defensive filename logic into private helpers.

#### [media_service.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/data_source/remote/media/media_service.dart)
- Consolidate `uploadMedia` to reduce duplication between Web and Mobile branches.
- Extract `_getSafeFileName` helper.
- Extract `_createMultipartFile` helper.
- Add comments explaining the "defensive" nature of the filename fallback.

---

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no new issues or unused imports were missed.

### Manual Verification
- **Web**:
    - Upload an image (with and without cropping).
    - Upload a PDF.
    - Verify successful upload in both cases.
- **Mobile**:
    - Upload an image (with and without cropping).
    - Upload a PDF.
    - Verify successful upload in both cases.
- **Network Inspection (Web)**:
    - Check that the `filename` in multipart data is still present and correct.
