import 'package:flutter/material.dart';

import '../../../../core/theme/theme_data.dart';

class MultiSelectChip extends StatefulWidget {
  // !: The tags get reset everytime one tries to edit
  final List<String> tagsList;
  final Function(List<String>)? onSelectionChanged;

  const MultiSelectChip(this.tagsList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    final List<Widget> choices = [];
    for (final item in widget.tagsList) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2.00),
          child: ChoiceChip(
            selectedColor: kOrange,
            backgroundColor: kOrangeLight,
            label: Text(
              item,
              style: Theme.of(context).textTheme.overline,
            ),
            selected: selectedChoices.contains(item),
            onSelected: (selected) {
              setState(
                () {
                  selectedChoices.contains(item)
                      ? selectedChoices.remove(item)
                      : selectedChoices.add(item);
                  widget.onSelectionChanged!(selectedChoices);
                },
              );
            },
          ),
        ),
      );
    }
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
  const SelectChip(this.keys, {this.onSelection});
  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<SelectChip> {
  List<Widget> _buildChoiceList() {
    final List<Widget> choices = [];
    for (final key in widget.keys) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.00),
        child: ActionChip(
          backgroundColor: kOrangeLight,
          label: Text(key, style: Theme.of(context).textTheme.overline),
          onPressed: () => widget.onSelection!(key),
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: _buildChoiceList(),
    );
  }
}

class DisplayChip extends StatefulWidget {
  final List<String> tagsList;
  const DisplayChip(this.tagsList);

  @override
  State<DisplayChip> createState() => _DisplayChipState();
}

class _DisplayChipState extends State<DisplayChip> {
  List<Widget> _buildChoiceList() {
    final List<Widget> chips = [];
    for (final tag in widget.tagsList) {
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2.00),
          child: Chip(
            backgroundColor: kOrangeLight,
            label: Text(tag, style: Theme.of(context).textTheme.caption),
          ),
        ),
      );
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: _buildChoiceList(),
    );
  }
}
