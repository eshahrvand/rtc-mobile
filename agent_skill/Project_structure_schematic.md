# AvatGPT — Project Structure Schematic
# Based on existing project pattern (layer-first, Cubit, GetIt, Freezed)

lib/
├── main.dart
├── locator.dart                         # GetIt dependency registration
│
├── base/                                # Shared models & enums
│   ├── enums/
│   │   └── theme_enum.dart
│   └── model/
│       ├── global_api_response.dart     # Generic API wrapper (freezed)
│       └── error_handler.dart
│
├── config/                              # App-wide utilities & constants
│   ├── constant.dart
│   ├── theme_config.dart
│   └── snackbar.dart
│
├── data_source/
│   │
│   ├── local/
│   │   └── prefs/
│   │       └── prefs.dart               # SharedPreferences wrapper
│   │
│   └── remote/
│       ├── service_util.dart            # Dio client / base API setup
│       │
│       ├── auth/
│       │   ├── auth_service.dart        # Retrofit service
│       │   └── model/
│       │       ├── token_dto_model.dart         # (freezed + json)
│       │       └── refresh_token_model.dart     # (freezed + json)
│       │
│       ├── splash/
│       │   ├── splash_service.dart
│       │   └── model/
│       │       └── validate_token_model.dart    # (freezed + json)
│       │
│       ├── chat/
│       │   ├── chat_service.dart
│       │   └── model/
│       │       ├── chat_model.dart
│       │       ├── message_model.dart
│       │       └── send_message_request.dart
│       │
│       └── models/                      # AI model selector
│           ├── model_service.dart
│           └── model/
│               └── ai_model_dto.dart
│
├── repository/                          # Data layer implementations
│   ├── auth/
│   │   └── auth_repository_impl.dart
│   ├── splash/
│   │   └── splash_repository_impl.dart
│   ├── chat/
│   │   └── chat_repository_impl.dart
│   └── models/
│       └── model_repository_impl.dart
│
├── domain/
│   └── repository/                      # Interfaces + UseCases
│       ├── auth/
│       │   ├── auth_repository.dart     # abstract interface
│       │   └── usecase/
│       │       └── auth_use_case.dart
│       ├── splash/
│       │   ├── splash_repository.dart
│       │   └── usecase/
│       │       └── splash_use_case.dart
│       ├── chat/
│       │   ├── chat_repository.dart
│       │   └── usecase/
│       │       └── chat_use_case.dart
│       └── models/
│           ├── model_repository.dart
│           └── usecase/
│               └── model_use_case.dart
│
└── ui/
├── router/
│   ├── app_route.dart               # Route names/constants
│   └── router.dart                  # GoRouter setup
│
├── theme/
│   ├── colors.dart
│   ├── text_theme.dart
│   └── theme.dart
│
└── presenters/
│
├── widget/                      # Shared/global widgets
│   ├── avatgpt_button.dart
│   ├── avatgpt_text_field.dart
│   └── avatgpt_appbar.dart
│
├── splash/
│   ├── splash.dart              # Screen
│   ├── bloc/
│   │   ├── splash_cubit.dart    # (freezed)
│   │   └── splash_state.dart
│   └── widget/
│       ├── loading_indicator_widget.dart
│       └── retry_widget.dart
│
├── auth/
│   ├── auth.dart                # Login/Register screen
│   ├── bloc/
│   │   ├── auth_cubit.dart      # (freezed)
│   │   └── auth_state.dart
│   └── widget/
│       ├── login_form_widget.dart
│       └── register_form_widget.dart
│
├── chat_list/
│   ├── chat_list.dart
│   ├── bloc/
│   │   ├── chat_list_cubit.dart
│   │   └── chat_list_state.dart
│   └── widget/
│       ├── chat_item_widget.dart
│       └── empty_chat_widget.dart
│
├── chat/
│   ├── chat.dart
│   ├── bloc/
│   │   ├── chat_cubit.dart
│   │   └── chat_state.dart
│   └── widget/
│       ├── message_bubble_widget.dart
│       ├── message_input_widget.dart
│       ├── image_preview_widget.dart
│       └── model_selector_sheet.dart
│
└── settings/
├── settings.dart
├── bloc/
│   ├── settings_cubit.dart
│   └── settings_state.dart
└── widget/
└── profile_info_widget.dart

# ─────────────────────────────────────────
# CONVENTIONS (for AI agent)
# ─────────────────────────────────────────

# State Management : Cubit (flutter_bloc)
# DI              : GetIt → locator.dart
# Code generation : Freezed + json_serializable
# HTTP client     : Dio + Retrofit (service_util.dart = base client)
# Local storage   : SharedPreferences → prefs/prefs.dart
# Routing         : GoRouter

# File naming     : snake_case
# Class naming    : PascalCase
# Cubit states    : sealed class with freezed (@freezed)

# ─────────────────────────────────────────
# BUILD ORDER FOR SPLASH (example)
# ─────────────────────────────────────────
# Step 1 → data_source/local/prefs/prefs.dart         (token storage)
# Step 2 → data_source/remote/splash/splash_service.dart + model
# Step 3 → domain/repository/splash/splash_repository.dart (interface)
# Step 4 → repository/splash/splash_repository_impl.dart
# Step 5 → domain/repository/splash/usecase/splash_use_case.dart
# Step 6 → locator.dart (register splash deps)
# Step 7 → ui/presenters/splash/ (cubit + screen + widgets)