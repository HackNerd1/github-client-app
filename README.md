# github_client_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 生成多语言

```bash
> dart run intl_generator:extract_to_arb --output-dir=l10n-arb ./lib/l10n/gm_localization.dart
> dart run intl_generator:generate_from_arb --output-dir=./lib/l10n --no-use-deferred-loading ./lib/l10n/gm_localization.dart l10n-arb/intl_*.arb
```
