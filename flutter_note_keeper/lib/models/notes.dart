class Notes {
  int id;
  String title;
  String decs;
  String date;
  int priority;

  //Constructor
  Notes(this.priority, this.title, this.date, [this.decs]);

  //Named Constructor (In Dart)
  Notes.withId(this.id, this.priority, this.title, this.date, [this.decs]);

  //Getters
  int get _id => id;
  String get _title => title;
  String get _desc => decs;
  String get _date => date;
  int get _priority => priority;

  //Setter
  set _title(String newTitle) {
    this.title = newTitle;
  }
  set _decs(String newDecs) {
    this.title = newDecs;
  }
  set _date(String newDate) {
    this.title = newDate;
  }
  set _priority(int newPriority) {
    this.priority = priority;
  }

  //Convert Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if(id != null){
      map['id'] = id;
    }
    map['title'] = title;
    map['decs'] = decs;
    map['priority'] = priority;
    map['date'] = date;

    return map;
  }

  //Extract a Note object from a Map object
  Notes.fromMapObject(Map<String, dynamic>map) {
    this.id = map['id'];
    this.title = map['title'];
    this.decs = map['decs'];
    this.date = map['date'];
    this.priority = map['priority'];
  }
}
