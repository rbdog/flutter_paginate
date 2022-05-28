//
// provider
//

import 'package:flutter/widgets.dart';

@immutable
class _Provider<T extends ChangeNotifier> extends InheritedWidget {
  const _Provider({
    required this.value,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final T value;

  @override
  bool updateShouldNotify(_Provider<T> oldWidget) => true;
}

@immutable
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierProvider({
    required this.create,
    required this.child,
    Key? key,
  }) : super(key: key);

  final T Function(BuildContext context) create;
  final Widget child;

  static T of<T extends ChangeNotifier>(
    BuildContext context, {
    bool listen = true,
  }) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<_Provider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<_Provider<T>>()
            ?.widget as _Provider<T>?;

    if (provider == null) {
      throw Error();
    }

    return provider.value;
  }

  @override
  ChangeNotifierProviderState createState() => ChangeNotifierProviderState<T>();
}

/// the state
class ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  /// type of value
  late T value;

  void listener() => setState(() {});

  @override
  void initState() {
    super.initState();
    value = widget.create(context);
    value.addListener(listener);
  }

  @override
  void dispose() {
    value
      ..removeListener(listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Provider<T>(value: value, child: widget.child);
  }
}

@immutable
class Consumer<T extends ChangeNotifier> extends StatelessWidget {
  const Consumer({
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context), child);
  }
}

extension ReadContext on BuildContext {
  T read<T extends ChangeNotifier>() {
    return ChangeNotifierProvider.of<T>(this, listen: false);
  }
}
