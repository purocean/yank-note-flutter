import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
enum StoreActions { Increment }

class AppState {
  var test = 1;
}

AppState counterReducer(AppState state, dynamic action) {
  if (action == StoreActions.Increment) {
    state.test++;
  }

  return state;
}

final _store =  Store<AppState>(counterReducer, initialState: AppState());

Store<AppState> getStore () => _store;

class AppStoreConnector extends StoreConnector<AppState, Store<AppState>> {
  AppStoreConnector({
    required Widget Function(
      BuildContext context,
      Store<AppState> store,
    ) builder,
  }) : super(builder: builder, converter: (store) => store);
}
