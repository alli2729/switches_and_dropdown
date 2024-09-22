import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // create an empty list for dropdown items
  // var items = []
  //     .map(
  //       (val) => DropdownMenuItem<String>(value: val, child: Text(val)),
  //     )
  //     .toList();

  List<DropdownMenuItem<String>> items = [];

  // create controller fo textfield and key for form
  final _addController = TextEditingController();
  final _editController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // value is for DropDownMenu
  String? value;

  @override
  Widget build(BuildContext context) {
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

  //* WIDGETS------------------------------------------

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
      // validator: _validator,
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
            onPressed: () => _addToList(_addController.text),
            icon: const Icon(Icons.add_circle_outline)),
        IconButton(
            onPressed: () => _removeFromList(_addController.text),
            icon: const Icon(Icons.remove_circle_outline)),
        IconButton(
            onPressed: () => _editList(value!),
            icon: const Icon(Icons.edit_outlined)),
      ],
    );
  }

  Widget _dropDown() {
    return DropdownButton<String>(
      hint: (items.isEmpty) ? const Text('Its Empty !') : const Text('Select'),
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

  //* METHODS------------------------------------------

  void _addToList(String input) {
    // validate
    if (_formKey.currentState?.validate() ?? false) {
      // checking if there is 'input' in the list
      if (items.any(
        (item) => item.value! == input.trim(),
      )) {
        _showDuplicateDialog(input);
      } else {
        setState(() {
          // add input to list
          items.add(DropdownMenuItem(value: input, child: Text(input)));
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
      if (items.any((item) => item.value == input)) {
        // remove item from list
        setState(() {
          items.removeWhere((item) => item.value == input);
          _addController.clear();
        });
      } else {
        // say there is no match for 'input'
        _showNoMatchSnackBar(input);
      }
    }
  }

  void _editList(String value) {
    // edit selected item from list
    setState(() {
      int index = items.indexWhere((item) => item.value == value);
      items[index] = DropdownMenuItem(
          value: _editController.text, child: Text(_editController.text));
      _editController.clear();
    });
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

  String? _validator(value) {
    // not allowing user to pass empty input
    if (value == null || value.isEmpty) {
      return 'Input is required !';
    }
    return null;
  }
}
