---
name: RapidCare Identity
colors:
  surface: '#f7fafd'
  surface-dim: '#d7dadd'
  surface-bright: '#f7fafd'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f4f7'
  surface-container: '#ebeef1'
  surface-container-high: '#e5e8eb'
  surface-container-highest: '#e0e3e6'
  on-surface: '#181c1e'
  on-surface-variant: '#414752'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eef1f4'
  outline: '#717783'
  outline-variant: '#c1c6d4'
  surface-tint: '#005faf'
  primary: '#005dac'
  on-primary: '#ffffff'
  primary-container: '#1976d2'
  on-primary-container: '#fffdff'
  inverse-primary: '#a5c8ff'
  secondary: '#b6171e'
  on-secondary: '#ffffff'
  secondary-container: '#da3433'
  on-secondary-container: '#fffbff'
  tertiary: '#2959b3'
  on-tertiary: '#ffffff'
  tertiary-container: '#4772ce'
  on-tertiary-container: '#fffdff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d4e3ff'
  primary-fixed-dim: '#a5c8ff'
  on-primary-fixed: '#001c3a'
  on-primary-fixed-variant: '#004786'
  secondary-fixed: '#ffdad6'
  secondary-fixed-dim: '#ffb3ac'
  on-secondary-fixed: '#410003'
  on-secondary-fixed-variant: '#930010'
  tertiary-fixed: '#d9e2ff'
  tertiary-fixed-dim: '#b0c6ff'
  on-tertiary-fixed: '#001945'
  on-tertiary-fixed-variant: '#00429c'
  background: '#f7fafd'
  on-background: '#181c1e'
  surface-variant: '#e0e3e6'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -1px
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 26px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  gutter: 16px
  margin-mobile: 20px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 24px
  touch-target: 48px
---

## Brand & Style

The design system is engineered for high-stakes healthcare environments where speed and clarity are paramount. The brand personality balances **Urgency** with **Composure**, ensuring that while the interface communicates the critical nature of emergency services, it does not induce panic in the user.

The visual style follows a **Corporate / Modern** aesthetic, heavily influenced by Material Design 3. It utilizes a structured hierarchy of information, generous tap targets for high-stress interactions, and a clean, spacious layout that minimizes cognitive load. The emotional response is one of absolute reliability, professional competence, and immediate assistance.

## Colors

This palette is rooted in the functional semiotics of emergency medicine. 

- **Primary Blue (#1976D2):** Used for the dominant action thread. It represents stability and professional medical care.
- **Secondary Red (#D32F2F):** Reserved strictly for emergency triggers, alerts, and life-critical information. Use sparingly to maintain its psychological impact.
- **Tertiary Dark Blue (#0D47A1):** Utilized for headers and navigation elements to provide a "grounding" weight to the mobile interface.
- **Surface Colors:** Pure White is the primary canvas. A soft Neutral Blue-Grey (#F4F7FA) is used for background grouping to reduce eye strain compared to pure grey.

## Typography

The design system utilizes **Inter** for its exceptional legibility and systematic performance. The type scale is optimized for "glanceability"—the ability to extract key information (like ambulance ETA or patient vitals) in less than a second. 

High-contrast weights (SemiBold and Bold) are used for critical data points, while regular weights are reserved for instructional text. Line heights are slightly increased to prevent text crowding in data-heavy views.

## Layout & Spacing

The layout follows a **Fluid Grid** model optimized for mobile-first deployment. It uses a 4px baseline shift to ensure all elements align to a consistent vertical rhythm. 

- **Margins:** 20px side margins provide a generous safety buffer for one-handed thumb use.
- **Touch Targets:** All interactive elements (buttons, toggles, chips) must maintain a minimum height of 48px.
- **Vertical Rhythm:** Use `stack-md` (16px) for standard element separation and `stack-lg` (24px) to separate distinct functional blocks or cards.

## Elevation & Depth

This design system employs **Tonal Layers** combined with soft **Ambient Shadows** to establish hierarchy. 

- **Level 0 (Base):** Neutral background surface.
- **Level 1 (Cards):** Main content containers. Use a subtle 4px blur shadow with 5% opacity of the Tertiary Blue to "lift" the card without creating harsh edges.
- **Level 2 (Buttons/Modals):** Elements requiring immediate interaction. These feature a more pronounced shadow (8px blur) to indicate they are "floating" above the medical data.
- **State Changes:** When an element is pressed, it should "sink" visually by reducing shadow spread, providing tactile-like feedback.

## Shapes

The shape language is defined by **Rounded** geometry (8px standard, 16px-24px for large containers). This softens the clinical nature of the app, making the technology feel more approachable and "human."

- **Standard Elements:** Buttons and input fields use 8px (`rounded-md`).
- **Main Containers:** Top-level cards and bottom sheets use 24px (`rounded-xl`) on top corners to align with Material Design 3 surface standards.
- **Status Indicators:** Pills and tags should be fully rounded (999px) to distinguish them from interactive buttons.

## Components

### Buttons
- **Primary Action:** Solid Primary Blue background with White text. Used for "Confirm," "Call Dispatch," or "Start Navigation."
- **Emergency Action:** Solid Emergency Red. Reserved for "Cancel Request" or "Report Critical Change."
- **Secondary:** Outlined Blue with 1.5px stroke. Used for less urgent tasks like "View History."

### Cards
Cards are the primary organizational unit. They should have a 1px border of #E0E0E0 in addition to their Level 1 elevation to ensure clear boundaries on high-brightness screens.

### Inputs
Fields must have persistent labels (Material 3 style) and a 56px minimum height. The active state should use a 2px Primary Blue border.

### Chips & Status Labels
- **ETA Chip:** Surface Variant background with Primary Blue text.
- **Critical Alert Chip:** Soft Red tint background with Emergency Red text.

### Progress Indicators
Linear progress bars should be used for ongoing processes (e.g., "Ambulance En Route"). Use a pulsing animation for the Primary Blue bar to indicate active movement.