import 'dart:io';

String fixture(String fileName) {
  return File("test/$fileName").readAsStringSync();
}
