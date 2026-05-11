# Engineering DNA: UI Component System

## 1. Engineering Mindset
The developer views UI components not just as visual elements, but as **"Self-Correcting Units of Logic."** They prioritize component autonomy over architectural purity.

- **Problem Solving via Defensive Component Design:** Components are designed to be "resilient to bad data." They heavily use local state duplication (e.g., copying props into `initState`) to ensure that even if a parent widget's state is unstable, the component maintains a consistent visual state.
- **Abstraction through Aggregation:** Instead of a "Small Widget" philosophy, they favor **"Omni-Components."** A single image component handles five different formats (Network, SVG, Lottie, File, Asset) and multiple stylistic variations (Circle, Micro). This reduces the number of unique imports a developer needs but increases the internal branching complexity of the component.
- **Trade-off (Internal Complexity for External Simplicity):** They consciously move complex logic (like RTL detection or platform-specific web focus handling) inside the low-level widgets. This makes the "Call Site" extremely clean but makes the base components harder to maintain.

## 2. Decision Patterns
- **Linguistic Resilience:** Every text-based component is "Culture Aware" by default. Logic for RTL (Right-to-Left) detection is baked into the base text widget, ensuring that the UI "just works" for both Persian and English without the developer explicitly setting alignments in the screen files.
- **The "Explicit Override" Pattern:** Components provide sensible defaults (often pulling from a custom palette) but expose nearly every internal property for manual overrides. This reveals a mindset that trusts the developer's situational judgment over a rigid design system.
- **Null-Safety via Hardcoded Fallbacks:** There is a pervasive use of the null-coalescing operator (`??`) tied to hardcoded "Magic Numbers" (e.g., `height: 52`, `borderRadius: 8`). This ensures the UI never breaks, but it anchors the design to specific values across the codebase.

## 3. Dependency & Communication Rules
- **Component-Level "Gating":** Low-level UI components (like Cards) are allowed to know about business concepts like "Country Codes" or "Permission Status." This violates standard "Pure UI" rules but allows for extremely rapid feature development where a card can "lock itself" based on global state.
- **Style Prop-Drilling:** Instead of relying exclusively on `Theme.of(context)`, components frequently pass down raw `TextStyle` and `Color` parameters. The component acts as a filter that merges its own defaults with the developer's specific overrides.
- **Platform Branching at the Leaf:** Platform checks (Web vs. Mobile) are performed at the lowest possible level (inside the Text Field or Image widget). This keeps the screens entirely platform-agnostic.

## 4. Implicit Rules
- **The Prefix Ritual:** Every custom widget must carry the brand prefix. This serves as a psychological marker distinguishing "Safe/Project-Aware" components from raw Material widgets.
- **The "Skeleton" Capability:** Complex cards and charts must support an "isLoading" flag internally, often wrapping themselves in a shimmer effect. The responsibility for "Waiting UI" lies with the component, not the screen.
- **Interactive Wrapped Foundations:** Nearly every interactive surface is wrapped in a custom "InkWell" abstraction to ensure consistent ripple effects and haptic feedback across the entire system.

## 5. Replication Guide

To implement a new UI component (e.g., "Feature Slider") in this style, follow these steps:

### Step 1: The Omni-Constructor
Create a constructor that accepts every possible visual variable (colors, styles, paddings, heights). Use null-coalescing fallbacks to a centralized palette for every single one.
- *Abstract Logic:* `CLASS CustomComponent(color: inputColor ?? PALETTE.base, height: inputHeight ?? 48)`

### Step 2: Defensive State Initialization
If the component has an "Active" or "Loading" state, duplicate the incoming parameters into a local `State` object within `initState` and sync them in `didUpdateWidget`. This ensures internal consistency.

### Step 3: Bake-in Linguistic Intelligence
If the component displays text, wrap the rendering logic in an alignment-checker that detects the character set of the input string and flips the layout for RTL languages automatically.
- *Abstract Logic:* `ALIGNMENT = DETECT_RTL(inputString) ? RIGHT : LEFT`

### Step 4: Aggregate Format Handling
If the component handles media, add branching logic for every possible format (Network, Asset, Animation) within the same file. Use a central helper method to return the specific sub-widget.

### Step 5: Platform Guarding
Identify if the component behaves differently on the web (e.g., mouse-hover effects or focus handling). Add `kIsWeb` checks directly inside the `build` method to adjust behavior without changing the component's signature.
