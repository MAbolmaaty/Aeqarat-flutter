import 'package:aeqarat/src/models/drop_list_option_model.dart';
import 'package:flutter/material.dart';

class DropList extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListOptionModel dropListOptionModel;
  final Function(OptionItem optionItem) onOptionSelected;

  DropList(this.itemSelected, this.dropListOptionModel, this.onOptionSelected);

  @override
  _DropListState createState() => _DropListState(this.itemSelected, this.dropListOptionModel);
}

class _DropListState extends State<DropList>
    with SingleTickerProviderStateMixin {
  OptionItem optionItemSelected;
  final DropListOptionModel dropListOptionModel;

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _DropListState(this.optionItemSelected, this.dropListOptionModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
