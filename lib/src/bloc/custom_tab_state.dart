part of 'custom_tab_bloc.dart';

/// Represents the current state of the tab view.
@freezed
class CustomTabState with _$CustomTabState {
  const CustomTabState._();

  /// Initial uninitialized state.
  const factory CustomTabState.initial() = _Initial;

  /// Active tab view state with [itemCount] and [currentIndex].
  const factory CustomTabState.ready({
    required int itemCount,
    required int currentIndex,
  }) = _Ready;
}
