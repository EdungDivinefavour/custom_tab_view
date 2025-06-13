part of 'custom_tab_bloc.dart';

/// Events for CustomTabBloc which drive tab interaction.
@freezed
class CustomTabEvent with _$CustomTabEvent {
  const CustomTabEvent._();

  /// Initializes the tab view with [itemCount] and optional [initialIndex].
  const factory CustomTabEvent.initialize({
    required int itemCount,
    @Default(0) int initialIndex,
  }) = Initialize;

  /// Event triggered when a tab is selected or changed.
  const factory CustomTabEvent.tabChanged(int index) = TabChanged;
}
