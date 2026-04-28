import 'package:course_app/cart/cart_item.dart';
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
      _items.add(CartItem(name: text, quantity: quantity));
      quantity = 1;
      _controller.clear();
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
              itemBuilder: (_, index) =>
                  Text('${_items[index].name} - ${_items[index].quantity}'),
              itemCount: _items.length,
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
