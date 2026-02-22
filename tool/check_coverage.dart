import 'dart:io';

void main(List<String> args) {
  final minArg = args
      .firstWhere((arg) => arg.startsWith('--min='), orElse: () => '--min=0.35')
      .split('=')
      .last;

  final minCoverage = double.tryParse(minArg);
  if (minCoverage == null) {
    stderr.writeln('Invalid --min value: $minArg');
    exit(2);
  }

  final file = File('coverage/lcov.info');
  if (!file.existsSync()) {
    stderr.writeln('coverage/lcov.info not found');
    exit(2);
  }

  var found = 0;
  var hit = 0;

  for (final line in file.readAsLinesSync()) {
    if (line.startsWith('LF:')) {
      found += int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      hit += int.parse(line.substring(3));
    }
  }

  final coverage = found == 0 ? 0.0 : hit / found;
  final percent = (coverage * 100).toStringAsFixed(2);
  final threshold = (minCoverage * 100).toStringAsFixed(2);
  stdout.writeln(
    'Line coverage: $percent% (threshold: $threshold%)',
  );

  if (coverage < minCoverage) {
    stderr.writeln('Coverage threshold not met');
    exit(1);
  }
}
