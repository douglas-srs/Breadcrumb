# Breadcrumb
Breadcrumb is a framework to handle statusbar breadcrumbs.

Only iOS 9.0 is supported.

## Integrating Breadcrumb into your Theos projects
It’s really easy to integrate Breadcrumb into a Theos project. First, install Breadcrumb on your device.

Now, copy the dynamic libraries and headers into the location you cloned Theos to. (Hopefully you have `$THEOS`, `$THEOS_DEVICE_IP`, and `$THEOS_DEVICE_PORT` set and exported in your shell.)

```
scp -rP $THEOS_DEVICE_PORT root@$THEOS_DEVICE_IP:/Library/Frameworks/Breadcrumb.framework $THEOS/lib
```

Next, for all projects that will be using Breadcrumb, add it to the instance’s libraries:

```
MyAwesomeTweak_EXTRA_FRAMEWORKS += Breadcrumb
```

You can now use Breadcrumb in your project.

Please note that Breadcrumb is a framework. Frameworks are only properly supported with [kirb/theos](https://github.com/kirb/theos); other variants of Theos may or may not support it.

## Usage Examples

Create a Breadcrumb with default handler set to open the app with specified bundleId.

```
DSBreadcrumb *breadcrumb = [[DSBreadcrumb alloc] initWithTitle:@"Kiroboro" andBundleId:@"com.apple.Preferences"];
```

Create a Breadcrumb with custom block handler.

```
DSBreadcrumb *breadcrumb = [[DSBreadcrumb alloc] initWithTitle:@"Kiroboro" andBundleId:@"com.apple.Preferences" withHandler:^void ()
{
    NSLog(@"Kirb + Uroboro = Kiroboro");
}];
```

Get the current visible Breadcrumb on statusbar.

```
DSBreadcrumb *breadcrumb = [[DSBreadcrumb alloc] initWithVisibleBreadcrumb];
```

Show a Breadcrumb.

```
[breadcrumb showBreadcrumb];
```

Hide a Breadcrumb.

```
[breadcrumb hideBreadcrumb];
```

Change a Breadcrumb Title.

```
[breadcrumb setTitle:@"Awesome"];
```

Change a Breadcrumb BundleId.

```
[breadcrumb setBundleId:@"com.apple.mobiletimer"];
```


## License
Licensed under [Apache License, version 2.0](https://github.com/douglas-srs/Breadcrumb/blob/master/LICENSE.md).