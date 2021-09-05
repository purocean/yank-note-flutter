import 'package:redux/redux.dart';
import 'package:yank_note/models/app_state.dart';
import 'package:yank_note/models/repository.dart';
import 'package:yank_note/store/actions.dart';
import 'package:yank_note/support/helper.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, ActionCreateRepo>((state, action) {
    if (!state.repos.contains(action.item)) {
      state.repos.add(action.item);
    } else {
      showToast(msg: '已添加同名仓库');
    }

    return state;
  }),

  TypedReducer<AppState, ActionRenameRepo>((state, action) {
    if (state.repos.indexWhere((element) => element.name == action.newName) > -1) {
      showToast(msg: '已存在同名仓库');
      return state;
    }

    final idx = state.repos.indexOf(action.item);
    if (idx > -1) {
      state.repos[idx] = Repo(name: action.newName, path: action.item.path);
    }

    return state;
  }),

  TypedReducer<AppState, ActionRemoveRepo>((state, action) {
    state.repos.remove(action.item);
    return state;
  })
]);
