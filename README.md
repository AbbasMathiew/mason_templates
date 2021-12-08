# Mason Setup

Setup and install [mason](https://pub.dev/packages/mason)

# Templates

## Flutter Template

### Add brick globally

```
mason add -g --source git https://github.com/AbbasMathiew/mason_templates --path bricks/flutter_template
```

### Running the brick

In order to run the brick you need to run

```
mason make flutter_template
```

You will be prompted to enter 3 variables:

- applicationName: The name of the application itself. This will also be converted to snake case and used as the folder name.

- applicationId: The android application id.

- bundleId: The IOS bundle id.

### Android additional steps

Navigate to the android folder

```
cd ./android
```

Run these commands and replace `example_project` with the application name you chose in `snakecase` eg: monstar lab -> monstar_lab

```
keytool -genkey -v -keystore debug_key.jks -alias example_project_debug -keyalg RSA -keysize 2048 -validity 10000
```

```
keytool -genkey -v -keystore release_key.jks -alias example_project_release -keyalg RSA -keysize 2048 -validity 10000
```

### IOS additional steps

No additional steps for IOS needed















