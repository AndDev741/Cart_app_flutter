import 'package:course_app/cart/cart_item.dart';
import 'package:course_app/cart/cart_item_tile.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final TextEditingController _controller = TextEditingController();
  final List<CartItem> _items = [];
  int quantity = 1;

  void _addItem() {
    final text = _controller.text;
    if (text.trim().isEmpty) {
      return;
    }

    setState(() {
      _items.add(CartItem(id: DateTime.now().millisecondsSinceEpoch, name: text, quantity: quantity));
      quantity = 1;
      _controller.clear();
    });
  }

  void _removeItem(int id){
    setState(() {
      _items.removeWhere((item) => item.id == id);      
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Column(
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.02,
                  ),
                  child: DropdownButton<int>(
                    items: [1, 2, 3, 4]
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text(e.toString()),
                          ),
                        )
                        .toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          quantity = newValue;
                        });
                      }
                    },
                    value: quantity,
                  ),
                ),
                Expanded(child: TextField(controller: _controller)),
                ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => CartItemTile(key: ValueKey(_items[index].id), item: _items[index], onRemove: _removeItem),
              itemCount: _items.length,
              findChildIndexCallback: (Key key) {
                final valueKey = key as ValueKey<int>;
                final index = _items.indexWhere((item) => item.id == valueKey.value);
                return index >= 0 ? index : null;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
