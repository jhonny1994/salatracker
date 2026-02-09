import 'package:flutter/material.dart';
import 'package:salat_tracker/core/core.dart';

/// Dialog to collect and confirm a 4-digit PIN.
class PinSetupDialog extends StatefulWidget {
  const PinSetupDialog({super.key});

  @override
  State<PinSetupDialog> createState() => _PinSetupDialogState();
}

class _PinSetupDialogState extends State<PinSetupDialog> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _submit() {
    final pin = _pinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();
    final l10n = S.of(context);

    if (!RegExp(r'^\d{4}$').hasMatch(pin)) {
      setState(() => _errorText = l10n.securityPinDigitsError);
      return;
    }

    if (pin != confirmPin) {
      setState(() => _errorText = l10n.securityPinMismatchError);
      return;
    }

    Navigator.of(context).pop(pin);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AlertDialog(
      title: Text(l10n.securitySetPinTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _pinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: InputDecoration(labelText: l10n.securityPinLabel),
          ),
          TextField(
            controller: _confirmPinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: InputDecoration(
              labelText: l10n.securityConfirmPinLabel,
            ),
          ),
          if (_errorText != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _errorText!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
