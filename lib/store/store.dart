import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux/redux.dart';
import 'package:yank_note/models/app_state.dart';
import 'package:yank_note/store/reducer.dart';

Store<AppState>? _store;

Future<Store<AppState>> getStore () async {
  if (_store != null) {
    return _store!;
  }

  final persistor = Persistor<AppState>(
    debug: true,
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  final initialState = await persistor.load();

  _store = Store<AppState>(
    reducer,
    initialState: initialState ?? AppState(),
    middleware: [persistor.createMiddleware()]
  );

  return _store!;
}

class AppStoreConnector extends StoreConnector<AppState, Store<AppState>> {
  AppStoreConnector({
    required Widget Function(
      BuildContext context,
      Store<AppState> store,
    ) builder,
  }) : super(builder: builder, converter: (store) => store);
}
