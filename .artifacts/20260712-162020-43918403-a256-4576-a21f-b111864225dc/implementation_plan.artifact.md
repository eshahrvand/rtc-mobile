# Implementation Plan - Cross-Platform Media Handling with cross_file

This plan outlines the refactoring of media picking and uploading to use `XFile` from the `cross_file` package. This approach ensures compatibility across Android, iOS, and Web by avoiding direct `dart:io` `File` references in platform-agnostic code and utilizing `XFile`'s ability to handle both local paths and Web Blob URLs.

## User Review Required

> [!IMPORTANT]
> - `MediaItem` will now hold an `XFile` instead of a `dart:io` `File`.
> - All UI components displaying `MediaItem` will be updated to use `Image.network` for `XFile` on Web (via `xfile.path`) or `Image.file` on mobile.
> - The `MediaService` will be updated to use raw `Dio` for uploads, constructing `MultipartFile` from `XFile` bytes or path as appropriate.

## Proposed Changes

### Layer 0: Models

#### [media_item.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/media_picker/bloc/model/media_item.dart)
- Replace `File file` with `XFile xFile`.
- Import `package:cross_file/cross_file.dart`.

---

### Layer 1: Media Picker (Cubit & Widgets)

#### [media_picker_cubit.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/media_picker/bloc/media_picker_cubit.dart)
- Update all picking methods (`getMediaFromAsset`, `captureFromCamera`, `pickFromGalleryWeb`, `pickFile`) to return `MediaItem` containing an `XFile`.
- For `pickFile` (PDF), use `FilePicker.platform.pickFiles()` and convert the result to `XFile`.

#### [media_edit_screen.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/media_picker/widget/media_edit_screen.dart)
- Update `crop` to use `item.xFile.path` for the cropper (which works with Blob URLs on Web).
- Update display logic to use `Image.network(mediaItem.xFile.path)` on Web and `Image.file(File(mediaItem.xFile.path))` on mobile.

#### [pre_invoice_cubit.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/bloc/pre_invoice_cubit.dart)
- Update `mandatoryDocPath` and `optionalDocPaths` in `PreInvoiceState` to store `XFile` objects (or keep as paths if preferred, but `XFile` is safer for Web).
- Update `_uploadDocuments` to pass `XFile` to the repository.

---

### Layer 2: Repository Layer

#### [media_repository.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/repository/media/media_repository.dart)
- Update `uploadMedia` signature to accept `XFile`.
- Call `_mediaService.uploadMedia(category: category, xFile: xFile)`.

---

### Layer 3: Service Layer (API)

#### [media_service.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/data_source/remote/media/media_service.dart)
- Implement `uploadMedia` using raw `Dio`.
- For Web, use `MultipartFile.fromBytes(await xFile.readAsBytes(), ...)` or `MultipartFile.fromPath(xFile.path, ...)` depending on what works best with current Dio version and Web environment. Usually `fromBytes` is most reliable on Web.

---

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no syntax errors or type mismatches.
- Run `dart run build_runner build --delete-conflicting-outputs` to update Freezed files.

### Manual Verification
- Test image picking and cropping on Android/iOS emulator.
- Test image picking and cropping on Flutter Web.
- Test PDF picking on all platforms.
- Verify file upload headers and body format via proxy or logs.
