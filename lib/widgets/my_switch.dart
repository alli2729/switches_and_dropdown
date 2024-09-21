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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Switch ${widget.id}'),
        const Spacer(),
        _removeButton(),
        _switch(),
      ],
    );
  }

  Widget _removeButton() {
    return IconButton(
        onPressed: (switchValue) ? (() => widget.onPressed(widget.id)) : null,
        icon: const Icon(Icons.delete_forever));
  }

  Widget _switch() {
    return Switch(
      value: switchValue,
      onChanged: (value) => setState(() => switchValue = value),
    );
  }
}
