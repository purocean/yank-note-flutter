import 'package:yank_note/models/repository.dart';

class ActionCreateRepo {
  final Repo item;

  ActionCreateRepo(this.item);
}

class ActionRenameRepo {
  final Repo item;
  final String newName;

  ActionRenameRepo(this.item, this.newName);
}

class ActionRemoveRepo {
  final Repo item;

  ActionRemoveRepo(this.item);
}
