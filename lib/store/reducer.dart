import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:yank_note/models/app_state.dart';
import 'package:yank_note/store/actions.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, ActionAddRepo>((state, action) {
    if (!state.repos.contains(action.item)) {
      state.repos.add(action.item);
    } else {
      Fluttertoast.showToast(msg: '已添加同名仓库');
    }

    return state;
  }),

  TypedReducer<AppState, ActionRemoveRepo>((state, action) {
    state.repos.remove(action.item);
    return state;
  })
]);
