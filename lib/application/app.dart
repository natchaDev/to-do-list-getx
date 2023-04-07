import 'package:flutter/widgets.dart';
import '../di/container.dart';
import 'env.dart';

class App extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    EnvironmentConfig env,
    DiContainer? di,
  ) builder;
  final EnvironmentConfig env;

  App({
    Key? key,
    required this.builder,
    required this.env,
    required DiContainer container,
  }) : super(key: key) {
    Di(container);
    Di().container!.singleton<EnvironmentConfig>(env);
  }

  @override
  _App createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    Di().container!.singleton<BuildContext>(context);
    return widget.builder(
      context,
      widget.env,
      Di().container,
    );
  }
}
