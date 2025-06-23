# boxdemo

A new Flutter project for a Box demo . Th show the boxes in "C" Shape.

## Getting Started

To clone this repo we need to copy this link:
 https://github.com/rahulkushwaha482/boxdemo


# Logic of Box of C

First we device the one upper row , then vertical column and last Row.
 of user enter number of boxes = 6
```
 _numberOfBox =6
 now number of      final h = _numberOfBox ~/ 3;
                    final v = _numberOfBox - 2 * h;

```

## Now generate the box of size according to h and v
Code of Box where Animated container added 
```
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
  ```

  On the tap of Box container , we store the box in a new list with their state to true .
  After the check all box state are true using 
  ```
  if (_boxStates.every((b) => b)) {
      _startReversal();
    }
    ```

If the state is true , we can start reversing if color 

# Atlast we should clear the addedm box list of taps .
