# Task: Fix Empty `filename` on Cropped Images for Web

Investigate and fix the issue where cropped images on Web have an empty filename, causing server validation errors during upload.

## Progress
- [x] Task 1: Investigation
    - [x] Trace `XFile.name` from picking (`ImagePicker`, `FilePicker`)
    - [x] Trace `XFile.name` through `MediaEditScreen.crop`
    - [x] Trace `XFile.name` before `MediaService.uploadMedia`
    - [x] Report root cause
- [x] Task 2: Fix Preservation of Filename
    - [x] Update `MediaEditScreen.crop` to preserve `name` and `mimeType`
- [x] Task 3: Defensive Fallback in `MediaService`
    - [x] Add `safeName` and `_extensionFromMime` in `MediaService`
- [x] Verification
    - [x] Run `flutter analyze`
    - [x] Verify non-empty `filename` in multipart request (browser DevTools)
    - [x] Confirm successful upload on Web

## Completed
All tasks successfully finished and confirmed by the user.
