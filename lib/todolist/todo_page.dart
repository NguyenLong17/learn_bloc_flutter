import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/todolist/todo_bloc.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  ToDoCubit _todoCubit = ToDoCubit();
  TextEditingController todoController = TextEditingController();

  // final listtodo = <ToDo>[];
  bool color = true;
  late ToDo itemSelected;
  late ToDo toDo;

  @override
  void initState() {
    // TODO: implement initState
    _todoCubit.createData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          IconButton(
            onPressed: () {
              _todoCubit.addNewDataToDo(todoController.text);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
              onPressed: () {
                _todoCubit.removeToDo(itemSelected);
              },
              icon: const Icon(
                Icons.dangerous,
              ))
        ],
      ),
      body: BlocBuilder<ToDoCubit, ToDoState>(
        bloc: _todoCubit,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 4),
                child: const Text('Input Todo'),
              ),
              Container(
                padding: const EdgeInsets.all(32),
                child: TextField(
                  controller: todoController,
                  decoration: const InputDecoration(
                    hintText: 'Todo...',
                  ),
                ),
              ),
              Expanded(child: buildListToDo()),
              const SizedBox(
                height: 16,
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildListToDo() {
    return ListView.separated(
      padding: const EdgeInsets.all(32),
      itemBuilder: (context, index) {
        final todo = _todoCubit.listtodo[index];
        return GestureDetector(
          child: buildItem(todo),
          onTap: () {
            itemSelected = todo;
            _todoCubit.setColorItemSelected(todo);
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: _todoCubit.listtodo.length,
    );
  }

  Widget buildItem(ToDo todo) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      color: todo.color ? Colors.green : Colors.grey,
      child: Column(children: [
        Text(todo.name),
        Text(todo.datetime),
      ]),
    );
  }

}
