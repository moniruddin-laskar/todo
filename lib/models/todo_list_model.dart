class ToDoListModel {
  dynamic id;
  dynamic title;
  dynamic isAlarmSet;
  dynamic alarmDate;
  dynamic createdOn;
  dynamic toDoStatus;

  ToDoListModel({this.id,this.title, this.isAlarmSet, this.createdOn, this.toDoStatus, this.alarmDate});

  ToDoListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    title = json['title'] ?? "";
    isAlarmSet = json['isAlarmSet'] ?? "";
    alarmDate = json['alarmDate'] ?? "";
    createdOn = json['createdOn'] ?? "";
    toDoStatus = json['toDoStatus'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['isAlarmSet'] = isAlarmSet;
    data['alarmDate'] = alarmDate;
    data['createdOn'] = createdOn;
    data['toDoStatus'] = toDoStatus;
    return data;
  }
}
