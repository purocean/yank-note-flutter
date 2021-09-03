import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:yank_note/store/actions.dart';
import 'package:yank_note/store/store.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, ActionAddRepo>((state, action) {
    if (!state.repos.contains(action.item)) {
      state.repos = [action.item];
    } else {
      Fluttertoast.showToast(msg: '已添加同名仓库');
    }

    return state;
  }),
]);
