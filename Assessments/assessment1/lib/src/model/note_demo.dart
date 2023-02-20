//@dart=2.9
class Notes {
  int _id;
  String _product;
  String _category;
  int _price;
  int _quantity;
  // String _price;
  // String _quantity;
  int _total;
  String _date;
  bool _deleted;

  Notes(this._product, this._category, this._price, this._quantity, this._total,
      this._date,
      [this._deleted = false]);

  Notes.withId(this._id, this._product, this._price, this._quantity, this._date,
      this._total, this._category,
      [this._deleted = false]);

  int get id => _id;

  String get date => _date;

  String get product => _product;
  int get price => _price;
  int get quantity => _quantity;
  int get total => _total;
  String get category => _category;
  bool get deleted => _deleted;

  set total(int value) {
    _total = value;
  }

  set id(int value) {
    _id = value;
  }

  set date(String value) {
    _date = value;
  }

  set price(int value) {
    _price = value;
  }

  set quantity(int value) {
    _quantity = value;
  }

/*  set price(String value) {
    if (value.length <= 255) {
      this._price = value;
    }
  }

  set quantity(String value) {
    if (value.length <= 255) {
      this._quantity = value;
    }
  }*/

  set category(String value) {
    if (value.length <= 255) {
      this._category = value;
    }
  }

  set product(String value) {
    if (value.length <= 255) {
      this._product = value;
    }
  }

  set deleted(bool value) {
    this._deleted = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['product'] = _product;
    map['category'] = _category;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['total'] = _total;
    map['date'] = _date;
    map['deleted'] = _deleted ? 1 : 0;

    return map;
  }

  Notes.fromMapObject(Map<String, dynamic> map) {
    if (map['id'] is int) {
      this._id = map['id'];
    } else if (map['id'] is String) {
      this._id = int.parse(map['id']);
    }
    // _id = map['id'];
    _product = map['product'];
    _category = map['category'];
    if (map['price'] is int) {
      this._price = map['price'];
    } else if (map['price'] is String) {
      this._price = int.parse(map['price']);
    }
    // _price = map['price'];
    if (map['quantity'] is int) {
      this._quantity = map['quantity'];
    } else if (map['quantity'] is String) {
      this._quantity = int.parse(map['quantity']);
    }
    // _quantity = map['quantity'];
    // if(map[''] is int){
    // this.  = map[''];
    // }else if(map[''] is String){
    // this.  = int.parse(map['']);
    // }
    _total = map['total'];
    _date = map['date'];
    this._deleted = map['deleted'] == 1;
  }
}

class DeletedNotes {
  int _id;
  String _product;
  String _category;
  String _date;
  int _price;
  int _quantity;
  int _total;
  bool _deleted;

  DeletedNotes(this._product, this._category, this._date, this._price,
      this._quantity, this._total,
      [this._deleted = false]);

  DeletedNotes.withId(this._id, this._product, this._category, this._date,
      this._price, this._quantity, this._total,
      [this._deleted = false]);

  int get id => _id;
  String get product => _product;
  String get category => _category;
  String get date => _date;
  int get price => _price;
  int get quantity => _quantity;
  int get total => _total;
  bool get deleted => _deleted;

  set id(int value) {
    _id = value;
  }

  set product(String value) {
    if (value.length <= 255) {
      this._product = value;
    }
  }

  set category(String value) {
    if (value.length <= 255) {
      this._category = value;
    }
  }

  set date(String value) {
    this._date = value;
  }

  set price(int value) {
    this._price = value;
  }

  set quantity(int value) {
    this._quantity = value;
  }

  set total(int value) {
    this._total = value;
  }

  set deleted(bool value) {
    this._deleted = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['product'] = _product;
    map['category'] = _category;
    map['date'] = _date;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['total'] = _total;
    map['deleted'] = _deleted ? 1 : 0;

    return map;
  }

  DeletedNotes.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._product = map['product'];
    this._category = map['category'];
    this._date = map['date'];
    this._price = map['price'];
    this._quantity = map['quantity'];
    this._total = map['total'];
    this._deleted = map['deleted'] == 1;
  }
}
