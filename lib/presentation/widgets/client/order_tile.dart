import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final isChecked;
  final String? taskText;
  final void Function(bool?)? onChangedTask;
  final void Function()? onDelete;

  const OrderTile(
      {Key? key,
      this.taskText,
      this.isChecked,
      this.onChangedTask,
      this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete),
      ),
      title: Text(
        taskText!,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onChangedTask,
      ),
    );
  }
}
