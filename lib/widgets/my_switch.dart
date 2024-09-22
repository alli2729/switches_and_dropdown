import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  MySwitch({
    super.key,
    // required this.id,
    required this.onPressed,
  }) : id = ++sid;

  static int sid = 0;
  final int id;
  final void Function(int) onPressed;

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  final _controller = TextEditingController();
  bool switchValue = false;
  bool isEdit = false;
  String name = '';

  @override
  void initState() {
    name = 'Switch ${widget.id}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _fieldOrText(),
        _buttons(),
      ],
    );
  }

  //* Widgets------------------------------------------------------------------

  Widget _buttons() {
    return Row(
      children: [
        _removeButton(),
        _editButton(),
        _switch(),
      ],
    );
  }

  Widget _fieldOrText() {
    if (isEdit) return Expanded(child: TextField(controller: _controller));
    return Text(name);
  }

  Widget _removeButton() {
    return IconButton(
        onPressed: (switchValue) ? null : (() => widget.onPressed(widget.id)),
        icon: const Icon(Icons.delete_forever));
  }

  Widget _editButton() {
    return IconButton(
        onPressed: (_editSwitch),
        icon: (isEdit) ? const Icon(Icons.done) : const Icon(Icons.edit));
  }

  Widget _switch() {
    return Switch(
      value: switchValue,
      onChanged: (value) => setState(() => switchValue = value),
    );
  }

  //* Methods------------------------------------------------------------------

  _editSwitch() {
    setState(() {
      name = _controller.text;
      isEdit = !isEdit;
    });
  }
}
