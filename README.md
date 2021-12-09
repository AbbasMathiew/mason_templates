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

- applicationId: This will be used as the android's `applicationId` and IOS's `bundleId`.
