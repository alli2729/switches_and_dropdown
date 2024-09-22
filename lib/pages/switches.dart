import 'package:flutter/material.dart';
import '../widgets/my_switch.dart';

class Switches extends StatefulWidget {
  const Switches({super.key});

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  final List<MySwitch> _switches = [];
  // int id = 0;

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

  Widget _fab() {
    return FloatingActionButton(
      elevation: 0,
      onPressed: _addSwitch,
      child: const Icon(Icons.add),
    );
  }

  void _addSwitch() {
    setState(() {
      _switches.add(MySwitch(onPressed: (id) => _removeSwitch(id)));
    });
  }

  void _removeSwitch(int id) {
    setState(() {
      _switches.removeWhere((item) => item.id == id);
    });
  }
}
