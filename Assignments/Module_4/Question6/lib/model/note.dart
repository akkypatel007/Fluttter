//@dart=2.9
class Notes {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Notes(this._title, this._date, this._priority, [this._description]);

  Notes.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  int get id => _id;

  String get date => _date;

  String get title => _title;

  int get priority => _priority;

  String get description => _description;
  set id(int value) {
    _id = value;
  }

  set priority(int value) {
    if (value >= 1 && value <= 2) {
      this._priority = value;
    }
  }

  set date(String value) {
    _date = value;
  }

  set description(String value) {
    if (value.length <= 255) {
      this._description = value;
    }
  }

  set title(String value) {
    if (value.length <= 255) {
      this._title = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  Notes.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
