import 'dart:io';

Future<void> main() async {
  final now = DateTime.now();
  final applicationId = '{{applicationName}}';

  final nowEpoch = now.millisecondsSinceEpoch;
  final password = '$nowEpoch$applicationId';
  final passwordHash = password.hashCode;

  try {
    print('Setting up project');

    _setCurrentDirectory('{{#paramCase}}{{applicationName}}{{/paramCase}}');

    print('Running flutter pub get');
    await Process.run('flutter', ['pub', 'get']);
    print('Finished running flutter pub get');

    _setCurrentDirectory('android');

    print('Generating android release properties');
    _generateAndroidReleasePropertiesFile(passwordHash: passwordHash);
    print('Android release properties generated');

    print('Generating android debug key...');
    await _generateAndroidDebugKey();
    print('Android debug key generating');

    print('Generating android release key...');
    await _generateAndroidReleaseKey(passwordHash: passwordHash);
    print('Android release key generating');

    print('Finished setting up project');
  } catch (e) {
    throw e;
  }
}

void _generateAndroidReleasePropertiesFile({
  required int passwordHash,
}) {
  File('release_key.properties').writeAsString('''
storePassword=$passwordHash
keyPassword=$passwordHash
keyAlias={{#snakeCase}}{{applicationName}}{{/snakeCase}}_release
storeFile=../release_key.jks
''');
}

Future<void> _generateAndroidReleaseKey({
  required int passwordHash,
}) async {
  await Process.run('keytool', [
    '-genkey',
    '-dname',
    "cn=Monstarlab, ou=Monstarlab, o=Monstarlab, l=Prague, s=Czech, c=CZ",
    '-keypass',
    '$passwordHash',
    '-storepass',
    '$passwordHash',
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
}

Future<void> _generateAndroidDebugKey() async {
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
}

void _setCurrentDirectory(String path) {
  Directory.current = '${Directory.current.path}/$path';
}
