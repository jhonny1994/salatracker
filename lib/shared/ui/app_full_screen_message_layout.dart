import 'package:flutter/material.dart';
import 'package:salat_tracker/shared/design_constants.dart';

class AppFullScreenMessageLayout extends StatelessWidget {
  const AppFullScreenMessageLayout({
    required this.top,
    required this.middle,
    required this.bottom,
    super.key,
  });

  final Widget top;
  final Widget middle;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppLayout.contentMaxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              top,
              middle,
              bottom,
            ],
          ),
        ),
      ),
    );
  }
}
