
import 'package:hive_flutter/adapters.dart';

part 'quest.g.dart';

@HiveType(typeId: 1)
class Quest 
{
  @HiveField(0)
  String _quest;

  @HiveField(1)
  bool _done;

  Quest(this._quest, this._done);

  String getQuest() => _quest;
  void setQuest(String quest) => _quest = quest; 

  bool getDone() => _done;
  void setDone(bool done) => _done = done;

  @override
  String toString() {
    return "[ quest: $_quest done: $_done ]";
  }
}