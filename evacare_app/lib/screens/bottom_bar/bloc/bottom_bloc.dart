import 'package:equatable/equatable.dart';
import 'package:evacare_app/core/enum/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bottom_state.dart';

class BottomBarCubit extends Cubit <BottomBarState> {
  BottomBarCubit(): super(const BottomBarState(BottomBarItem.home, 0));
  
  void getBottomBarItem(BottomBarItem bottomBarItem) {
    switch (bottomBarItem) {
      case BottomBarItem.home:
        emit(BottomBarState(bottomBarItem, 0));
        break;
      case BottomBarItem.chat:
        emit(BottomBarState(bottomBarItem, 1));
        break;
      case BottomBarItem.settings:
        emit(BottomBarState(bottomBarItem, 2));
        break;
    }
  }
}