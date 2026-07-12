# Task: Cross-Platform Media Handling with cross_file

Refactor media picking and uploading to use `XFile` for compatibility across Android, iOS, and Web.

## Progress
- [/] Layer 0: Models
    - [/] Update `MediaItem` to use `XFile`
- [ ] Layer 1: Media Picker & Cubits
    - [ ] Update `MediaPickerCubit` methods
    - [ ] Update `PreInvoiceCubit` and its state
    - [ ] Update `OrdersCubit` and its state
- [ ] Layer 2: Repository Layer
    - [ ] Update `MediaRepository` signature
- [ ] Layer 3: Service Layer
    - [ ] Refactor `MediaService` to use raw `Dio` and `XFile`
- [ ] UI Components
    - [ ] Update `MediaEditScreen` display logic
    - [ ] Update `OrderUploadDocumentsSheet` and other UI components
- [ ] Verification
    - [ ] Run `build_runner`
    - [ ] Run `flutter analyze`
    - [ ] Manual verification (if possible)

## Next Steps
- Finish updating `MediaItem`.
- Update `MediaPickerCubit`.
