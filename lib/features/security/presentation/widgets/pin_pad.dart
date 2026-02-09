import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:salat_tracker/shared/shared.dart';

/// A secure PIN pad widget using [Pinput] for display and a
/// custom numeric keypad.
class PinPad extends StatefulWidget {
  const PinPad({
    required this.length,
    required this.onCompleted,
    this.isError = false,
    this.onBio,
    this.bioAvailable = false,
    super.key,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final bool isError;
  final VoidCallback? onBio;
  final bool bioAvailable;

  @override
  State<PinPad> createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onDigit(String digit) {
    if (_controller.text.length < widget.length) {
      unawaited(HapticFeedback.lightImpact());
      _controller.text += digit;
      if (_controller.text.length == widget.length) {
        widget.onCompleted(_controller.text);
        // Clear after a short delay or let parent handle?
        // Typically we wait for validation. Parent should clear if error.
        // For now, we leave it. If error, parent passes isError true.
      }
    }
  }

  void _onDelete() {
    if (_controller.text.isNotEmpty) {
      unawaited(HapticFeedback.lightImpact());
      _controller.text = _controller.text.substring(
        0,
        _controller.text.length - 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reset controller if error state is cleared
    // Actually, Pinput handles error state display.
    if (widget.isError && _controller.text.length == widget.length) {
      _controller.clear();
    }

    final theme = Theme.of(context);

    // Default Pinput theme
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: theme.colorScheme.error),
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.2),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PIN Display
        Pinput(
          length: widget.length,
          controller: _controller,
          focusNode: _focusNode,
          defaultPinTheme: defaultPinTheme,
          errorPinTheme: errorPinTheme,
          separatorBuilder: (index) => const Gap(AppSpacing.sm),
          obscureText: true,
          showCursor: false,
          readOnly: true, // We use our custom keypad
          onCompleted: widget.onCompleted,
          forceErrorState: widget.isError,
        ),
        const Gap(AppSpacing.xl),

        // Custom Numeric Keypad
        _Keypad(
          onDigit: _onDigit,
          onDelete: _onDelete,
          onBio: widget.onBio,
          bioAvailable: widget.bioAvailable,
        ),
      ],
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.onDigit,
    required this.onDelete,
    this.onBio,
    this.bioAvailable = false,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;
  final VoidCallback? onBio;
  final bool bioAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Constrain width for better ergonomics
      alignment: Alignment.center,
      child: Column(
        children: [
          _row(['1', '2', '3']),
          const Gap(AppSpacing.lg),
          _row(['4', '5', '6']),
          const Gap(AppSpacing.lg),
          _row(['7', '8', '9']),
          const Gap(AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Biometric button or empty space
              SizedBox(
                width: 72,
                height: 72,
                child: bioAvailable && onBio != null
                    ? IconButton(
                        onPressed: () {
                          unawaited(HapticFeedback.lightImpact());
                          onBio!();
                        },
                        icon: const Icon(Icons.fingerprint, size: 32),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(AppSpacing.md),
                        ),
                      )
                    : null,
              ),
              _key('0'),
              // Backspace button
              SizedBox(
                width: 72,
                height: 72,
                child: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.backspace_outlined),
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(AppSpacing.md),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map(_key).toList(),
    );
  }

  Widget _key(String digit) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => onDigit(digit),
          customBorder: const CircleBorder(),
          child: Center(
            child: Text(
              digit,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
