import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  int _numberOfBox = 0;
  List<bool> _boxStates = [];
  final List<int> _tapOrder = [];
  bool _isReversing = false;

  void _handleInput() {
    final value = int.tryParse(_controller.text);
    if (value == null || value < 5 || value > 25) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a number between 5 and 25')),
      );
      return;
    }

    setState(() {
      _numberOfBox = value;
      _boxStates = List.generate(_numberOfBox, (_) => false);
      _tapOrder.clear();
      _isReversing = false;
    });
  }

  void _onBoxTap(int index) {
    if (_isReversing || _boxStates[index]) return;

    setState(() {
      _boxStates[index] = true;
      _tapOrder.add(index);
    });

    if (_boxStates.every((b) => b)) {
      _startReversal();
    }
  }

  void _startReversal() async {
    setState(() {
      _isReversing = true;
    });

    for (int i = _tapOrder.length - 1; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _boxStates[_tapOrder[i]] = false;
      });
    }

    setState(() {
      _tapOrder.clear();
      _isReversing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('C Shape Boxes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Number  (5–25)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _handleInput,
                  child: Text('Show Box'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_numberOfBox > 0)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final h = _numberOfBox ~/ 3;
                    final v = _numberOfBox - 2 * h;
                    final boxSize = constraints.maxWidth / 8 - 6;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:
                                List.generate(h, (i) => _buildBox(i, boxSize)),
                          ),
                          SizedBox(height: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                v,
                                (i) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: _buildBox(h + i, boxSize),
                                    )),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: List.generate(
                                h, (i) => _buildBox(h + v + i, boxSize)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(int index, double size, {bool isRow = true}) {
    if (index >= _numberOfBox) return SizedBox.shrink();

    return GestureDetector(
      onTap: () => _onBoxTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: size,
        height: size,
        margin: EdgeInsets.only(right: isRow ? 2 : 0),
        decoration: BoxDecoration(
          color: _boxStates[index] ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
