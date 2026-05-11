# Engineering DNA: Design System & Theming

## 1. Engineering Mindset
The developer treats the theme system as a **"Visual Contract"** that bridges the gap between raw design tokens and functional utility. They prioritize **Consistency over Granularity**.

- **Problem Solving via Semantic Palettes:** Instead of selecting individual colors, the developer builds deep 10-point `MaterialColor` palettes for every semantic category (Warning, Error, Success). This ensures that any component needing a "lighter" or "darker" version of a semantic color has a predictable shade to pull from.
- **Trade-off (Semantic Leakage):** They consciously allow feature-specific color names (e.g., `finishChatColor`) to exist in the global theme file. This reveals a "Centralized Truth" philosophy where it's better to have a weirdly named global constant than a hardcoded value hidden in a widget.
- **Deliberate Avoidance:** They avoid the default Flutter/Material shadow system. Instead, they define their own layered `BoxShadow` constants to achieve a specific "Soft UI" aesthetic that standard Material 3 elevation doesn't provide.

## 2. Decision Patterns
- **Script-Specific Typography:** The developer recognizes that "Universal Typography" is a myth. They maintain separate configuration files for different languages (EN/FA) where font weights and sizes are tuned specifically for the visual density of that script.
- **Standardized Component Geometry:** Decoration logic (like `BoxDecoration` and `BoxShadow`) is extracted into factory functions or global lists. This ensures that every "Card" in the app feels identical without repeating complex shadow math.
- **The "Soft Black" Rule:** Pure black (#000000) is avoided. Text and shadows consistently pull from specific deep shades of a custom Gray palette, indicating a focus on eye comfort and high-end finish.

## 3. Dependency & Communication Rules
- **Locale-Driven Injection:** The theme is not a static constant. It is a function that accepts typography and font family parameters, meaning the visual "DNA" of the app is injected at the root based on the user's current context.
- **Shade-Based Access:** UI components are expected to reference shades (e.g., `.shade500`) rather than raw color variables. This creates a mental map where `500` is always the "Base" and other numbers are "States" (hover, disabled, active).
- **Separation of Concerns:** 
    - `Colors.dart` = Raw material.
    - `TextTheme.dart` = Linguistic tuning.
    - `Theme.dart` = The assembly line that combines them into a `ThemeData`.

## 4. Implicit Rules
- **Palette Completeness:** You never define a single color. If you need a new color, you define the entire 50-1000 shade range.
- **Shadow Layering:** A "Shadow" is never a single entry. It is a list of multiple `BoxShadow` objects with varying opacities and offsets to create a realistic depth effect.
- **Theme-Propagated Geometry:** BorderRadius and Elevation are handled via the `ThemeData` or centralized helper functions, never hardcoded in the widget build method.

## 5. Replication Guide

To implement a new visual feature matching this DNA, follow these steps:

### Step 1: Define the Semantic Palette
If a new color category is needed, create a `MaterialColor` with 10 shades. Even if the shades aren't mathematically derived, they must be organized by intensity.
- *Abstract Logic:* `CONSTANT BrandPalette = MaterialColor(base, {50: light, ..., 500: base, ..., 900: dark})`

### Step 2: Tune for the Script
If adding a new language, create a dedicated `TextTheme` file. Adjust `FontWeight` values based on how that specific font appears compared to English (e.g., making it 100 units heavier for better legibility).

### Step 3: Layer the Depth
When creating a new "elevated" element, do not use `elevation`. Use a list of at least two `BoxShadow` objects with very low opacities (alpha < 20).
- *Abstract Logic:* `LIST ElevationShadow = [BoxShadow(offsetA, blurA, colorAlpha1), BoxShadow(offsetB, blurB, colorAlpha2)]`

### Step 4: Component Assembly
Add a helper function to the theme system that returns a `BoxDecoration` using the standard palette. Use optional parameters for specific overrides while keeping the defaults tied to the global constants.

### Step 5: Root Integration
Ensure the new theme components are passed through the main theme constructor function, allowing them to be swapped dynamically based on the application's locale.
