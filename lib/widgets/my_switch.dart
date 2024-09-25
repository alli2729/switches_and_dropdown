import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  MySwitch({
    super.key,
    required this.id,
    required this.onPressed,
  }) : name = id.toString();

  final int id;
  final String name;
  final void Function(int) onPressed;

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  final _controller = TextEditingController();
  bool switchValue = false;
  bool isEdit = false;
  String _name = '';

  @override
  void initState() {
    _name = widget.name;
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
    return Text('Switch $_name');
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
      _controller.text = _name;
    });
  }

  _doneEdit() {
    setState(() {
      _name = _controller.text;
      isEdit = !isEdit;
    });
  }
}
