import 'package:flutter/material.dart';

import 'lazy_index_stack.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "LazyIndexedStack", home: DemoPage());
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _index = 0;
  final List<Widget> _children = List.generate(
    3,
    (index) => _SubIndexPage(index, key: UniqueKey(),),
  );

  void _selectedIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IndexedStack")),
      body: Column(
        children: [
          Expanded(
            child: LazyIndexedStack(
              index: _index,
              children: _children,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.filter_1), label: '1'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_2), label: '2'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_3), label: '3'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
           _children[1] = _AnotherIndexPage(1, key: UniqueKey(),);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SubIndexPage extends StatefulWidget {
  const _SubIndexPage(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  State<_SubIndexPage> createState() => _SubIndexPageState();
}

class _SubIndexPageState extends State<_SubIndexPage> {
  DateTime? _displayTime;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          // subtract means sub the time
          _displayTime =
              DateTime.now().subtract(const Duration(milliseconds: 300));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          const Spacer(),
          Text(
            'This is page ${widget.index}',
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 64),
            textAlign: TextAlign.center,
          ),
          if (_displayTime == null)
            const Spacer()
          else
            Expanded(child: Text('initState() ran at $_displayTime')),
        ],
      );
    });
  }
}


class _AnotherIndexPage extends StatefulWidget {
  const _AnotherIndexPage(this.index,{Key? key}) : super(key: key);

  final int index;
  @override
  State<_AnotherIndexPage> createState() => _AnotherIndexPageState();
}

class _AnotherIndexPageState extends State<_AnotherIndexPage> {
  DateTime? _displayTime;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          // subtract means sub the time
          _displayTime =
              DateTime.now().subtract(const Duration(milliseconds: 300));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          const Spacer(),
          Text(
            'Another Index Page ${widget.index}',
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 64),
            textAlign: TextAlign.center,
          ),
          if (_displayTime == null)
            const Spacer()
          else
            Expanded(child: Text('initState() ran at $_displayTime')),
        ],
      );
    });
  }
}

