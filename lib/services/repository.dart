import 'package:yank_note/models/repository.dart';
import 'package:yank_note/services/state.dart';
import 'package:yank_note/support/helper.dart';

void addRepo (Repo repo) {
  if (!appState.repos.contains(repo)) {
    appState.repos = [...appState.repos, repo];
  } else {
    showToast(msg: '已添加同名仓库');
  }
}

void renameRepo (Repo repo, String newName) {
  if (appState.repos.indexWhere((element) => element.name == newName) > -1) {
    showToast(msg: '已存在同名仓库');
    return;
  }

  appState.repos = appState.repos.map((element) {
    return element == repo ? Repo(name: newName, path: repo.path) : element;
  }).toList();
}

void removeRepo (Repo repo) {
  appState.repos = appState.repos.where((element) => element != repo).toList();
}
