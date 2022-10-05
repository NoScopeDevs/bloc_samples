import 'dart:io';

/// Removes the file or folder pointed by the path passed as first parameter.
Future<void> run(List<String> args) async {
  try {
    if (args.isEmpty) {
      throw ArgumentError('A file or directory path should be provided');
    }
    final elementPath = args.first;
    final elementType = FileSystemEntity.typeSync(elementPath);
    switch (elementType) {
      case FileSystemEntityType.directory:
        final dir = Directory(elementPath);
        dir.deleteSync(recursive: true);
        break;
      case FileSystemEntityType.file:
        final file = File(elementPath);
        file.deleteSync(recursive: true);
        break;
      case FileSystemEntityType.notFound:
        print('The element <$elementPath> does not exist');
        break;
      case FileSystemEntityType.pipe:
      case FileSystemEntityType.link:
      case FileSystemEntityType.unixDomainSock:
        throw UnsupportedError('Unsupported element type');
    }
  } catch (e) {
    stdout.write('$e');
    exitCode = 1;
  }
}
