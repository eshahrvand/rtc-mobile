import 'package:flutter_bloc/flutter_bloc.dart';

/// The policy gate disposes the active screen while HTTP requests may still be
/// completing. Their results must not emit into that disposed screen's cubit.
abstract class MountedCubit<State> extends Cubit<State> {
  MountedCubit(super.initialState);
  @override
  void emit(State state) {
    if (!isClosed) super.emit(state);
  }
}
