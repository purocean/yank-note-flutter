import 'package:yank_note/models/repository.dart';

class ActionAddRepo {
  final Repo item;

  ActionAddRepo(this.item);
}

class ActionRemoveRepo {
  final Repo item;

  ActionRemoveRepo(this.item);
}
