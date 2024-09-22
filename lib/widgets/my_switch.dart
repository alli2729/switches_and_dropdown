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
        (!isEdit) ? _editButton() : _doneButton(),
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
    return IconButton(onPressed: (_editSwitch), icon: const Icon(Icons.edit));
  }

  Widget _doneButton() {
    return IconButton(onPressed: (_doneEdit), icon: const Icon(Icons.done));
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
      isEdit = !isEdit;
      _controller.text = name;
    });
  }

  _doneEdit() {
    setState(() {
      name = _controller.text;
      isEdit = !isEdit;
    });
  }
}
