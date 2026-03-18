class Quest 
{
  String _quest;
  bool _done;

  Quest(this._quest, this._done);

  String getQuest() => _quest;
  void setQuest(String quest) => _quest = quest; 

  bool getDone() => _done;
  void setDone(bool done) => _done = done;
}