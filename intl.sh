dart run intl_generator:extract_to_arb --output-dir=l10n-arb ./lib/l10n/gm_localization.dart
dart run intl_generator:generate_from_arb --output-dir=./lib/l10n --no-use-deferred-loading ./lib/l10n/gm_localization.dart l10n-arb/intl_*.arb
