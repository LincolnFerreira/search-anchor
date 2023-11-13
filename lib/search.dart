import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notifications/titles.dart';

class SearchComponent extends StatefulWidget {
  final SearchController searchController;
  final Titles resultData;
  final Function(String text) fetchDataFromBackend;

  const SearchComponent({
    Key? key,
    required this.searchController,
    required this.resultData,
    required this.fetchDataFromBackend,
  }) : super(key: key);

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: widget.searchController,
      isFullScreen: false,
      builder: (context, controller) {
        return SearchBar(
          controller: widget.searchController,
          onChanged: (value) {
            if (value.isNotEmpty && !controller.isOpen) {
              controller.openView();
            }
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (context, controller) async {
        List<String> titles =
            await widget.fetchDataFromBackend(controller.value.text);
        widget.resultData.update(titles);

        if (controller.value.text.isEmpty && controller.isOpen) {
          controller.closeView(null);
        }
        return widget.resultData.items.isNotEmpty
            ? List.generate(
                widget.resultData.items.length,
                (index) => ListTile(
                  title: TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: 'Funcionalidade não implementada',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    },
                    child: Text(widget.resultData.items[index]),
                  ),
                ),
              )
            : List.generate(
                1,
                (index) => const ListTile(
                  title: Center(
                    child: Text(
                      "Sem resultados",
                    ),
                  ),
                ),
              );
      },
    );
  }
}
