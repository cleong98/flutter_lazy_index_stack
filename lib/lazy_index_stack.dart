import 'package:flutter/material.dart';

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    Key? key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <Widget>[],
  }) : super(key: key);

  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;
  final int? index;
  final List<Widget> children;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _activatedList = List.generate(
    widget.children.length,
    (index) => index == widget.index,
  );
  late final List<Widget> _currentChildren = [...widget.children];

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.index != oldWidget.index) {
      _activateIndex(widget.index);
    }

    // TODO: implement a more precise control for children updates
    _resetChildrenActivateStatus();
  }



  void _activateIndex(int? index) {
    if(index == null) return;
    // if origin activated list index bool is false
    if(!_activatedList[index]) {
      setState(() {
        _activatedList[index] = true;
        _currentChildren.clear();
        _currentChildren.addAll(widget.children);
      });
    }
  }

  void _resetChildrenActivateStatus() {
    final List<Widget> newChildren = widget.children;
    if(newChildren.isEmpty) return;

    for(int index = 0; index < newChildren.length; index++) {

      if(_currentChildren[index].runtimeType != newChildren[index].runtimeType) {
        setState(() {
          _activatedList[index] = false;
        });
      }
    }

  }


  List<Widget> _buildChildren(BuildContext context) {
    return List<Widget>.generate(widget.children.length, (int index) {
      if(_activatedList[index]) {
        return widget.children[index];
      }
      return const SizedBox.shrink();
    } );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      index: widget.index,
      children: _buildChildren(context),
    );
  }
}
