import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoCubit extends Cubit<ToDoState> {
  ToDoCubit() : super(ToDoInitState());

  List<ToDo> listtodo = [];

  void createData() {
    for(Map<String, dynamic> obj in dataToDo) {
      final model = ToDo(
          name: obj["Name"],
          datetime: obj["Date"],
          color: obj["Color"],
      );
      listtodo.add(model);

    }
    emit(ToDoState());

  }
  void addNewDataToDo(String name) {
    if(name.isNotEmpty) {
      listtodo.add(ToDo(name: name, datetime: DateTime.now().toString(), color: false));
    }
    emit(ToDoState());
  }

  void removeToDo(ToDo todo) {
    listtodo.remove(todo);
    emit(ToDoState());
  }

  void setColorItemSelected(ToDo todo) {
    todo.color = !todo.color;
    emit(ToDoState());

  }


}

class ToDoInitState extends ToDoState {}

class ToDoState {}

class ToDo {
  String name;
  String datetime;
  bool color = false;

  ToDo({required this.name, required this.datetime, required this.color});

}

const dataToDo = [
  {
    "Name": "Đi học",
    "Date": "12/8/2022",
    "Color": false,
  },
  {
    "Name": "Thức dậy",
    "Date": "06:00",
    "Color": false,
  },
  {
    "Name": "Làm việc",
    "Date": "08:00",
    "Color": false,
  },
];
