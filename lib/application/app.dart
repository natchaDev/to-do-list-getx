import 'package:flutter/widgets.dart';

class App extends StatefulWidget {
  final Widget Function(
    BuildContext context,
  ) builder;

  App({
    Key? key,
    required this.builder,
  });

  @override
  _App createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context
    );
  }
}
