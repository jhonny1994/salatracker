import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Dialog to collect and confirm a 6-digit PIN.
class PinSetupDialog extends StatefulWidget {
  const PinSetupDialog({super.key});

  @override
  State<PinSetupDialog> createState() => _PinSetupDialogState();
}

class _PinSetupDialogState extends State<PinSetupDialog> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _pinController.addListener(_onPinChanged);
    _confirmPinController.addListener(_onPinChanged);
  }

  void _onPinChanged() {
    if (mounted) {
      setState(() {
        if (_errorText != null) {
          _errorText = null;
        }
      });
    }
  }

  @override
  void dispose() {
    _pinController.removeListener(_onPinChanged);
    _confirmPinController.removeListener(_onPinChanged);
    _pinController.dispose();
    _confirmPinController.dispose();
    _pinFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final pin = _pinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();
    final l10n = S.of(context);

    if (!RegExp(r'^\d{6}$').hasMatch(pin)) {
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
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.securityPinLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const Gap(AppSpacing.sm),
          Pinput(
            length: 6,
            controller: _pinController,
            focusNode: _pinFocusNode,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            obscureText: true,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
          ),
          const Gap(AppSpacing.lg),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.securityConfirmPinLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const Gap(AppSpacing.sm),
          Pinput(
            length: 6,
            controller: _confirmPinController,
            focusNode: _confirmFocusNode,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            obscureText: true,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
          ),
          if (_errorText != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
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
          onPressed:
              _pinController.text.length == 6 &&
                  _confirmPinController.text.length == 6
              ? _submit
              : null,
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
