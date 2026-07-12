# Walkthrough - Fix Empty `filename` on Cropped Images for Web

I have resolved the issue where cropped images on Flutter Web were being uploaded with an empty `filename`, causing the server to reject them.

## Root Cause Identified
The investigation (via debug prints) confirmed that while the image carried a correct name after being picked, the name was lost during the cropping step. Specifically, `MediaEditScreen.crop` was creating a new `XFile` from the cropped path but was not passing the original filename to the new instance, resulting in `filename=""` in the multipart request.

## Key Fixes

### 1. Preserving Filename in `MediaEditScreen`
Updated the cropping logic to explicitly forward the original filename and mime type to the new `XFile` instance created after cropping.
- **File**: `lib/ui/presenters/media_picker/widget/media_edit_screen.dart`

### 2. Defensive Fallback in `MediaService`
Added a safety net in the upload service to ensure a non-empty filename is ALWAYS sent to the server. If `XFile.name` is missing, it now generates a timestamped name with the appropriate extension based on the mime type.
- **File**: `lib/data_source/remote/media/media_service.dart`

### 3. Cleanup
- Removed all temporary debug prints used during the investigation.
- Corrected the `FilePicker` API call (removed `.platform`) which was causing an analyzer error.
- Cleaned up unused imports in `PreInvoiceCubit`.

## Verification Summary

### Automated Tests
- Ran `flutter analyze` and verified that all critical errors related to the fix are resolved.

### Manual Verification Required
- Pick and crop an image on **Web**.
- Upload the image.
- Verify in browser DevTools → Network that the `Content-Disposition` header for the file part now includes a non-empty `filename`.
- Confirm that the server returns a successful response (200/201).
