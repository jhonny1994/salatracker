import 'dart:io';

void main() {
  final result = Process.runSync('git', ['ls-files', '.env']);
  final output = (result.stdout as String).trim();

  if (output.isNotEmpty) {
    stderr.writeln(
      'Tracked .env file detected. Remove it from git history/index.',
    );
    exit(1);
  }

  stdout.writeln('No tracked .env file detected.');
}
