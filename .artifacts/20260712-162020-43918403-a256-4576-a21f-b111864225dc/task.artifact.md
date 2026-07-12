# Task: Clean Up Media Picker / Repository / Service Code

Refactor media-related code to remove debug artifacts, reduce duplication, and improve readability without changing behavior.

## Progress
- [x] Task 1: Research and Planning
- [x] Task 2: UI & Presenter Cleanup
    - [x] Remove prints from `MediaPickerCubit`
    - [x] Clean up imports in `MediaPickerCubit` and `MediaEditScreen`
- [x] Task 3: Data Layer Refactor
    - [x] Refactor `MediaService.uploadMedia`
    - [x] Extract helpers for safe filename and multipart file creation
    - [x] Add defensive comments
- [x] Task 4: Verification
    - [x] Run `flutter analyze`
    - [x] Create walkthrough

## Completed
Cleanup is finished. No behavior was changed, and code hygiene has been improved.
