import 'package:flutter/material.dart';

/// A settings tile with a switch toggle control.
class SettingsSwitchTile extends StatelessWidget {
  /// Creates a [SettingsSwitchTile].
  const SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwitchListTile(
      secondary: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
