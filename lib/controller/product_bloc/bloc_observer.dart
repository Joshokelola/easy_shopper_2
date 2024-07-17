

import 'package:flutter_bloc/flutter_bloc.dart';

class GetProductsBlocObserver extends BlocObserver {

  const GetProductsBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }
}