import 'package:custom_tab_view/src/bloc/custom_tab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
/// ```
class CustomTabView extends StatefulWidget {
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Color? indicatorColor;
  final Color? labelColor;

  const CustomTabView({
    super.key,
    required this.tabBuilder,
    required this.pageBuilder,
    this.indicatorColor,
    this.labelColor,
  });

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _setupController(int itemCount, int currentIndex) {
    if (_controller == null ||
        _controller!.length != itemCount ||
        _controller!.index != currentIndex) {
      _controller?.dispose();
      _controller = TabController(
        length: itemCount,
        vsync: this,
        initialIndex: currentIndex,
      );
      _controller!.addListener(() {
        if (_controller!.indexIsChanging) return;
        context.read<CustomTabBloc>().add(
              CustomTabEvent.tabChanged(_controller!.index),
            );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomTabBloc, CustomTabState>(
      builder: (context, state) {
        return state.maybeWhen(
          ready: (itemCount, currentIndex) {
            _setupController(itemCount, currentIndex);

            return Column(
              children: [
                SizedBox(
                  height: 45,
                  child: TabBar(
                    controller: _controller,
                    indicatorColor: widget.indicatorColor,
                    labelColor: widget.labelColor,
                    tabs: List.generate(
                      itemCount,
                      (i) => widget.tabBuilder(context, i),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: List.generate(
                      itemCount,
                      (i) => widget.pageBuilder(context, i),
                    ),
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
