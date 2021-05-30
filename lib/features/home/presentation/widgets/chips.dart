import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> tagsList;
  final Function(List<String>)? onSelectionChanged;
  MultiSelectChip(this.tagsList, {this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.tagsList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.00),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged!(selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class SelectChip extends StatefulWidget {
  final List<String> keys;
  final Function(String)? onSelection;
  SelectChip(this.keys, {this.onSelection});
  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<SelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.keys.forEach((key) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.00),
        child: ActionChip(
          label: Text(key),
          onPressed: () => widget.onSelection!(key),
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class DisplayChip extends StatefulWidget {
  final List<String> tagsList;
  DisplayChip(this.tagsList);

  @override
  State<DisplayChip> createState() => _DisplayChipState();
}

class _DisplayChipState extends State<DisplayChip> {
  _buildChoiceList() {
    List<Widget> chips = [];
    widget.tagsList.forEach((tag) {
      chips.add(Container(
        padding: const EdgeInsets.all(2.00),
        child: Chip(
          label: Text(tag),
        ),
      ));
    });
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
