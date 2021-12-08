import 'dart:io';

Future<void> main() async {
  try {
    _setCurrentDirectory('{{#snakeCase}}{{applicationName}}{{/snakeCase}}');
    print('Running flutter pub get');
    await Process.run('flutter', ['pub get']);
    print('Finished running flutter pub get');
    _setCurrentDirectory('android');
    print('Creating android debug key...');
    await Process.run('keytool', [
      '-genkey',
      '-dname',
      "cn=Monstarlab, ou=Monstarlab, o=Monstarlab, l=Prague, s=Czech, c=CZ",
      '-keypass',
      '123456',
      '-storepass',
      '123456',
      '-v',
      '-keystore',
      'debug_key.jks',
      '-alias',
      '{{#snakeCase}}{{applicationName}}{{/snakeCase}}_debug',
      '-keyalg',
      'RSA',
      '-keysize',
      '2048',
      '-validity',
      '10000'
    ]);
    print('Android debug key created');
    print('Creating android release key...');
    await Process.run('keytool', [
      '-genkey',
      '-dname',
      "cn=Monstarlab, ou=Monstarlab, o=Monstarlab, l=Prague, s=Czech, c=CZ",
      '-keypass',
      '123456',
      '-storepass',
      '123456',
      '-v',
      '-keystore',
      'release_key.jks',
      '-alias',
      '{{#snakeCase}}{{applicationName}}{{/snakeCase}}_release',
      '-keyalg',
      'RSA',
      '-keysize',
      '2048',
      '-validity',
      '10000'
    ]);
    print('Android release key created');
  } catch (e) {
    throw e;
  }
}

void _setCurrentDirectory(String path) {
  Directory.current = '${Directory.current.path}/$path';
}
