import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var items = []
      .map(
        (val) => DropdownMenuItem<String>(value: val, child: Text(val)),
      )
      .toList();

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            _textField(),
            _addButton(),
            _dropDown(),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return TextFormField(
      validator: _validator,
      controller: _controller,
    );
  }

  String? _validator(value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  Widget _addButton() {
    return IconButton(
        onPressed: () => _addToList(_controller.text),
        icon: const Icon(Icons.add));
  }

  Widget _dropDown() {
    return DropdownButton<String>(
        hint: const Text('Its Empty !'),
        value: value,
        items: items,
        onChanged: (v) => setState(() => value = v));
  }

  void _addToList(String input) {
    // validate
    if (_formKey.currentState?.validate() ?? false) {
      // checking if there is duplicate
      if (items.any(
        (item) => item.value!.contains(input.trim()),
      )) {
        _showDuplicateDialog(input);
      } else {
        setState(() {
          // add input to list
          items.add(DropdownMenuItem(value: input, child: Text(input)));
          // clear the text field
          _controller.clear();
        });
      }
    }
  }

  Future<dynamic> _showDuplicateDialog(String value) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$value is Duplicate'),
          ),
        );
      },
    );
  }
}
