import 'dart:io';

void main(List<String> args) {
  print('First is "${args[0]}" second is: "${args[0]}". This is:');
  print('${args.join(' ')}');

  print('Files:');

  final dir = Directory.current.absolute;
  print('Absolute: ${dir.path}');

  print('Items:\n${dir.listSync().map((entity) => entity.path).join(', ')}');

  print('Goodbye!');
}
