import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //SEARCH BAR
        Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 10.0,
      ),
      child: TextFormField(
        // controller: _searchController,
        onFieldSubmitted: null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 230, 230, 230),
          hintText: "Search User",
          hintStyle: const TextStyle(color: Color.fromARGB(255, 79, 79, 79)),
          labelText: 'Search User',
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 133, 133, 133)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color.fromARGB(255, 133, 133, 133),
          ),
        ),
      ),
    );
  }
}
