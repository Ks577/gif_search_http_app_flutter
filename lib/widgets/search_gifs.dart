import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  final Function(String) onSearch;

  const SearchForm({super.key, required this.onSearch});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        constraints: const BoxConstraints(maxHeight: 48),
        hintText: "Search..",
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.white,
        suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              widget.onSearch(_controller.text);
            }),
      ),
      style: const TextStyle(fontSize: 18, color: Colors.white),
      onSubmitted: ((value) {
        widget.onSearch(value);
      }),
    );
  }
}
