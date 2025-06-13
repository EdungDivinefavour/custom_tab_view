import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_tab_bloc.freezed.dart';
part 'custom_tab_event.dart';
part 'custom_tab_state.dart';

/// Business logic controller for managing tab selection and count.
class CustomTabBloc extends Bloc<CustomTabEvent, CustomTabState> {
  CustomTabBloc() : super(const CustomTabState.initial()) {
    on<Initialize>(_onInitialize);
    on<TabChanged>(_onTabChanged);
  }

  void _onInitialize(Initialize event, Emitter<CustomTabState> emit) {
    emit(
      CustomTabState.ready(
        itemCount: event.itemCount,
        currentIndex: event.initialIndex,
      ),
    );
  }

  void _onTabChanged(TabChanged event, Emitter<CustomTabState> emit) {
    state.maybeWhen(
      ready: (count, _) => emit(
        CustomTabState.ready(itemCount: count, currentIndex: event.index),
      ),
      orElse: () {},
    );
  }
}
