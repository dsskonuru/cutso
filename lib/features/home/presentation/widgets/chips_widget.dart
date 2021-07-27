import 'package:flutter/material.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../main_common.dart';

class MultiSelectChip extends StatefulWidget {
  final Set<String> tags;
  final Set<String>? selectedTags;
  final Function(Set<String>)? onSelectionChanged;

  const MultiSelectChip(this.tags,
      {this.onSelectionChanged, this.selectedTags});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  Set<String> selectedChoices = {};

  List<Widget> _buildChoiceList() {
    if (widget.selectedTags != null) {
      selectedChoices.addAll(widget.selectedTags!);
    }
    final List<Widget> choices = [];
    for (final String tag in widget.tags) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2.00),
          child: ChoiceChip(
            selectedColor: kOrange,
            backgroundColor: kOrangeLight,
            label: Text(tag, style: Theme.of(context).textTheme.button),
            selected: selectedChoices.contains(tag),
            onSelected: (selected) {
              setState(
                () {
                  selectedChoices.contains(tag)
                      ? selectedChoices.remove(tag)
                      : selectedChoices.add(tag);
                  widget.onSelectionChanged!(selectedChoices);
                },
              );
            },
          ),
        ),
      );
    }
    container.read(loggerProvider).i(selectedChoices.toList());
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

class SelectChip extends StatefulWidget {
  final List<String> tags;
  final String? selectedTag;
  final Function(String?)? onSelectionChanged;

  const SelectChip(this.tags, {this.onSelectionChanged, this.selectedTag});

  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<SelectChip> {
  String? selectedChip;

  List<Widget> _buildChoiceList() {
    selectedChip = widget.selectedTag;
    final List<Widget> choices = [];
    for (final String tag in widget.tags) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2.00),
          child: ChoiceChip(
            selectedColor: kOrange,
            backgroundColor: kOrangeLight,
            label: Text(tag, style: Theme.of(context).textTheme.button),
            selected: selectedChip == tag,
            onSelected: (selected) {
              setState(
                () {
                  if (selectedChip == tag) {
                    selectedChip = null;
                  } else {
                    selectedChip = tag;
                  }
                  widget.onSelectionChanged!(selectedChip);
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
