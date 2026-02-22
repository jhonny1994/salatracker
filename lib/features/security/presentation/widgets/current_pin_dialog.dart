import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

class CurrentPinDialog extends StatefulWidget {
  const CurrentPinDialog({super.key});

  @override
  State<CurrentPinDialog> createState() => _CurrentPinDialogState();
}

class _CurrentPinDialogState extends State<CurrentPinDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AlertDialog(
      title: Text(l10n.securityCurrentPinTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.securityCurrentPinLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const Gap(AppSpacing.sm),
          Pinput(
            length: 6,
            controller: _controller,
            focusNode: _focusNode,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            obscureText: true,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: _controller.text.trim().length == 6
              ? () => Navigator.of(context).pop(_controller.text.trim())
              : null,
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
