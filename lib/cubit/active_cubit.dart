import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_smart/cubit/active_state.dart';

class ActiveCubit extends Cubit<ActiveState> {
  ActiveCubit() : super(ActiveState(isActive: false));

  changeStatus() {
    emit(ActiveState(isActive: !state.isActive));
  }
}
