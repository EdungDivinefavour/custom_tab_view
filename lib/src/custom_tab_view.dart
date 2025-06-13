import 'package:flutter/material.dart';

/// CustomTabView is a reusable component for rendering a tabbed interface
/// with dynamic tab and page generation. It integrates with [CustomTabBloc]
/// for state management.
///
/// Use it with [BlocProvider] to initialize with item count and index.
///
/// Example:
/// ```dart
/// BlocProvider(
///   create: (_) => CustomTabBloc()
///     ..add(CustomTabEvent.initialize(itemCount: 3)),
///   child: CustomTabView(...),
/// )
///

class CustomTabView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) tabBuilder;
  final Widget Function(BuildContext context, int index) pageBuilder;
  final ValueChanged<int>? onPositionChange;
  final VoidCallback? onScroll;
  final int initPosition;
  final Color? indicatorColor;
  final Color? labelColor;

  const CustomTabView({
    Key? key,
    required this.itemCount,
    required this.tabBuilder,
    required this.pageBuilder,
    this.onPositionChange,
    this.onScroll,
    this.initPosition = 0,
    this.indicatorColor,
    this.labelColor,
  }) : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late int _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initPosition;
    _controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    _controller.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_controller.indexIsChanging) return;
    if (_currentPosition != _controller.index) {
      _currentPosition = _controller.index;
      widget.onPositionChange?.call(_currentPosition);
    }
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      _controller.dispose();
      _controller = TabController(
        length: widget.itemCount,
        vsync: this,
        initialIndex: _currentPosition.clamp(0, widget.itemCount - 1),
      );
      _controller.addListener(_handleTabChange);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _controller,
          indicatorColor: widget.indicatorColor,
          labelColor: widget.labelColor,
          tabs: List.generate(
              widget.itemCount, (i) => widget.tabBuilder(context, i)),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: List.generate(
                widget.itemCount, (i) => widget.pageBuilder(context, i)),
          ),
        ),
      ],
    );
  }
}
