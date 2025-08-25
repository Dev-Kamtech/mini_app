import 'package:flutter_bloc/flutter_bloc.dart';

class NavCubit extends Cubit<int> {
  NavCubit({int initialIndex = 0}) : super(initialIndex);

  void selectTab(int index) => emit(index);
}
