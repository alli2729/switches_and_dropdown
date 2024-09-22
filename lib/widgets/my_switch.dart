import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({
    super.key,
    required this.id,
    required this.onPressed,
  });

  final int id;
  final void Function(int) onPressed;

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool switchValue = false;
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _fieldOrText(),
        const Spacer(),
        _removeButton(),
        _editButton(),
        _switch(),
      ],
    );
  }

  Widget _fieldOrText() {
    if (isEdit) return const Expanded(child: TextField());

    return Text('Switch ${widget.id}');
  }

  Widget _removeButton() {
    return IconButton(
        onPressed: (switchValue) ? (() => widget.onPressed(widget.id)) : null,
        icon: const Icon(Icons.delete_forever));
  }

  Widget _editButton() {
    return IconButton(
        onPressed: (() => setState(() => isEdit = !isEdit)),
        icon: (isEdit) ? const Icon(Icons.cancel) : const Icon(Icons.edit));
  }

  Widget _switch() {
    return Switch(
      value: switchValue,
      onChanged: (value) => setState(() => switchValue = value),
    );
  }
}
