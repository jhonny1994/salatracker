import 'package:flutter/material.dart';
import 'package:salat_tracker/core/core.dart';

/// A dialog for selecting a notification reminder offset in minutes.
///
/// Presents a slider allowing the user to choose an offset between -60 and
/// +60 minutes relative to the scheduled prayer time.
class OffsetPickerDialog extends StatefulWidget {
  /// Creates an [OffsetPickerDialog].
  const OffsetPickerDialog({
    required this.initialValue,
    required this.title,
    super.key,
  });

  /// The initial offset value in minutes.
  final int initialValue;

  /// The title to display (typically the prayer name).
  final String title;

  @override
  State<OffsetPickerDialog> createState() => _OffsetPickerDialogState();
}

class _OffsetPickerDialogState extends State<OffsetPickerDialog> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return AlertDialog(
      title: Text('${l10n.settingsReminderOffset} - ${widget.title}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.offsetMinutes(_value.round()),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Slider(
            value: _value,
            min: -60,
            max: 60,
            divisions: 24, // 5 min increments
            label: l10n.offsetMinutes(_value.round()),
            onChanged: (value) => setState(() => _value = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _value.round()),
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
