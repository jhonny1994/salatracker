import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Shared async-state view for Riverpod [AsyncValue]s.
class AppAsyncValue<T> extends StatelessWidget {
  /// Creates an [AppAsyncValue].
  const AppAsyncValue({
    required this.value,
    required this.data,
    super.key,
    this.loading,
    this.error,
    this.retry,
    this.errorTitle,
    this.errorMessage,
    this.errorIcon = Icons.error_outline,
  });

  /// The async value to render.
  final AsyncValue<T> value;

  /// Builds the success state.
  final Widget Function(T data) data;

  /// Optional custom loading builder.
  final WidgetBuilder? loading;

  /// Optional custom error builder.
  final Widget Function(Object error, StackTrace stackTrace)? error;

  /// Optional retry callback for the default error state.
  final VoidCallback? retry;

  /// Optional title for the default error state.
  final String? errorTitle;

  /// Optional message for the default error state.
  final String? errorMessage;

  /// Optional icon for the default error state.
  final IconData errorIcon;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => loading?.call(context) ?? const _DefaultLoadingState(),
      error: (errorValue, stackTrace) =>
          error?.call(errorValue, stackTrace) ??
          _DefaultErrorState(
            title: errorTitle ?? S.of(context).errorLoadingData,
            message: errorMessage,
            icon: errorIcon,
            retry: retry,
          ),
      data: data,
    );
  }
}

class _DefaultLoadingState extends StatelessWidget {
  const _DefaultLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _DefaultErrorState extends StatelessWidget {
  const _DefaultErrorState({
    required this.title,
    required this.icon,
    this.message,
    this.retry,
  });

  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AppEmptyState(
      icon: icon,
      title: title,
      message: message,
      action: retry == null
          ? null
          : FilledButton.icon(
              onPressed: retry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.errorRetry),
            ),
    );
  }
}
