class Contact{
  int _id = 0;
  String _name = '';
  String _phone = '';

  
  void idIncerement(){
    _id++;
  }

  //konstruktor versi 1
  Contact(this._id,this._name, this._phone);

  //konstruktor versi 2: konversi dari map ke contact
  Contact.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _name = map['name'];
    _phone = map['phone'];
  }

  //getter
  int get id => _id;
  // ignore: unnecessary_getters_setters
  String get name => _name;
  // ignore: unnecessary_getters_setters
  String get phone => _phone;

  //setter
  set id(int value){
    _id = value;
  }
  set name(String value){
    _name = value;
  }
    set phone(String value){
    _phone = value;
  }

  //konversi dari contact ke map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }

}