import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:yank_note/store/reducer.dart';

enum StoreActions {
  AddRepo
}

class Repo {
  final String name;
  final String path;

  Repo({required this.name, required this.path});
}

class AppState {
  var repos = List<Repo>.empty();
}

final Map<StoreActions, AppState Function(AppState state, dynamic payload)> _reducers = {
  StoreActions.AddRepo: (state, payload) {
    state.repos.add(payload);
    return state;
  }
};

final _store =  Store<AppState>(reducer, initialState: AppState());

Store<AppState> getStore () => _store;

class AppStoreConnector extends StoreConnector<AppState, Store<AppState>> {
  AppStoreConnector({
    required Widget Function(
      BuildContext context,
      Store<AppState> store,
    ) builder,
  }) : super(builder: builder, converter: (store) => store);
}
