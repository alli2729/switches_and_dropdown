/*
  Ali Karimi
*/
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  // list of strings
  List<String> stringItems = [];
  // list of dropdown items : will initialize later
  List<DropdownMenuItem<String>> items = [];

  // create controller fo textfield and key for form
  final _addController = TextEditingController();
  final _editController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // value is for DropDownMenu
  String? value;

  @override
  Widget build(BuildContext context) {
    // before biulding page : change list of string to list of dropdown items
    _itemsToDropDown();
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _addTextField(),
            const SizedBox(height: 10),
            _editTextField(),
            _buttons(),
            _dropDown(),
          ],
        ),
      ),
    );
  }

  //* WIDGETS------------------------------------------------------------------

  Widget _addTextField() {
    return TextFormField(
      validator: _validator,
      controller: _addController,
      decoration: const InputDecoration(
        hintText: 'Type Somthing',
        label: Text('Input'),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _editTextField() {
    return TextFormField(
      enabled: (isSelected()),
      controller: _editController,
      decoration: const InputDecoration(
        hintText: 'Type Somthing',
        label: Text('Edit'),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            tooltip: 'Add',
            onPressed: () => _addToList(_addController.text),
            icon: const Icon(Icons.add_circle_outline)),
        IconButton(
            tooltip: 'Remove',
            onPressed: () => _removeFromList(_addController.text),
            icon: const Icon(Icons.remove_circle_outline)),
        IconButton(
            tooltip: 'Edit',
            onPressed: (isSelected()) ? () => _editList(value!) : null,
            icon: const Icon(Icons.edit_outlined)),
      ],
    );
  }

  Widget _dropDown() {
    return DropdownButton<String>(
      hint: (stringItems.isEmpty)
          ? const Text('Its Empty !')
          : const Text('Select'),
      value: value,
      items: items,
      onChanged: (v) => setState(
        () {
          _editController.text = v!;
          value = v;
        },
      ),
    );
  }

  //* METHODS------------------------------------------------------------------

  void _addToList(String input) {
    // validate
    if (_formKey.currentState?.validate() ?? false) {
      // checking if there is 'input' in the list
      if (stringItems.any((item) => item == input.trim())) {
        _showDuplicateDialog(input);
      } else {
        setState(() {
          // add input to list
          stringItems.add(input);
          // clear the text field
          _addController.clear();
        });
      }
    }
  }

  void _removeFromList(String input) {
    // validate
    if (_formKey.currentState?.validate() ?? false) {
      // if there is a match in list
      if (stringItems.any((item) => item == input)) {
        // remove item from list
        setState(() {
          // removing item
          stringItems.removeWhere((item) => item == input);
          // set value to null
          value = null;
          // clear both controllers
          _addController.clear();
          _editController.clear();
        });
      } else {
        // say there is no match for 'input'
        _showNoMatchSnackBar(input);
      }
    }
  }

  void _editList(String input) {
    // if field is empty
    if (_editController.text.isEmpty) {
      _showNoEmptySnackBar();
    } else
    // if there is duplicate in list
    if (stringItems.any((e) => e == _editController.text)) {
      _showDuplicateDialog(_editController.text);
    } else {
      setState(() {
        // finding index of input string
        int index = stringItems.indexWhere((item) => item == input);
        // change value to input
        stringItems[index] = _editController.text;
        // set value to chosen item
        value = stringItems[index];
        // clear controller
        _editController.clear();
      });
    }
  }

  Future<dynamic> _showDuplicateDialog(String value) {
    // showing dialog if there is duplicate in list
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '"$value" is already in the list',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _showNoMatchSnackBar(String value) {
    // showing snackBar in bottom of screen
    final snackBar = SnackBar(content: Text('"$value" is not in the list'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showNoEmptySnackBar() {
    // showing snackBar in bottom of screen
    const snackBar = SnackBar(content: Text('Cannot change to null'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String? _validator(value) {
    // not allowing user to pass empty input
    if (value == null || value.isEmpty) {
      return 'Input is required !';
    }
    return null;
  }

  void _itemsToDropDown() {
    // changing string list to dropdown item list
    items = stringItems
        .map(
          (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  bool isSelected() {
    if (value?.isNotEmpty ?? false) return true;
    if (items.isEmpty) return false;
    return false;
  }
}
