import 'dart:async';

import 'package:flutter/material.dart';

/// Custom Search input field, showing the search and clear icons.
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  const SearchInput(this.onSearchInput, {super.key});

  @override
  State<StatefulWidget> createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer debouncer;

  bool hasSearchEntry = false;

  SearchInputState();

  @override
  void initState() {
    super.initState();
    editController.addListener(onSearchInputChange);
  }

  @override
  void dispose() {
    editController.removeListener(onSearchInputChange);
    editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (editController.text.isEmpty) {
      debouncer.cancel();
      widget.onSearchInput(editController.text);
      return;
    }

    if (debouncer.isActive ?? false) {
      debouncer.cancel();
    }

    debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).canvasColor,
      ),
      child: Row(
        children: <Widget>[
          //Icon(Icons.search, color: Theme.of(context).textTheme.body1.color),
          SizedBox(width: 18),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search place", border: InputBorder.none,
              ),
              controller: this.editController,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  this.hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          //SizedBox(width: 8),
          if (this.hasSearchEntry)
            GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {
                this.editController.clear();
                setState(() {
                  this.hasSearchEntry = false;
                });
              },
            ),
        ],
      ),
    );
  }
}
