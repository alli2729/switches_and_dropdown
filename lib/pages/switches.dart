import 'package:flutter/material.dart';
import '../widgets/my_switch.dart';

class Switches extends StatefulWidget {
  const Switches({super.key});

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  final List<MySwitch> _switches = [];
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView.builder(
          itemCount: _switches.length,
          itemBuilder: (_, index) => _switches[index],
        ),
      ),
    );
  }

  //* Widgets-----------------------------------------------------------------

  Widget _fab() {
    return FloatingActionButton(
      elevation: 0,
      onPressed: _addSwitch,
      child: const Icon(Icons.add),
    );
  }

  //* Methods-----------------------------------------------------------------

  void _addSwitch() {
    _switches.add(MySwitch(onPressed: (id) => _removeSwitch(id), id: ++id));
    setState(() {});
  }

  void _removeSwitch(int id) {
    // removing with index
    int index = (_switches.indexWhere((item) => item.id == id));
    _switches.removeAt(index);
    // removing with id
    _switches.removeWhere((item) => item.id == id);
    setState(() {});
  }
}
