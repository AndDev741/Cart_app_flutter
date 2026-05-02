import 'package:course_app/cart/cart_item.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatefulWidget {
  final CartItem item;
  final Function(int) onRemove;
  
  const CartItemTile({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  bool _isBought = false;
  String loadingText = "";

  @override
  Widget build(BuildContext context) {
    debugPrint('build ${widget.item.name}, _isBought=$_isBought');
    return ListTile(
      leading: Checkbox(
        value: _isBought,
         onChanged: (bool? value) {
          setState(() {
            _isBought = value!;
          });
         }
      ),
      title: Text(widget.item.name),
      subtitle: Text('Qty: ${widget.item.quantity} -- $loadingText'),
      trailing: IconButton(
        onPressed: () => widget.onRemove(widget.item.id), 
        icon: Icon(Icons.delete, color: Colors.red,)
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    debugPrint('initState para item ${widget.item.id} (${widget.item.name})');
    fetchAfterInit();
  }

  void fetchAfterInit() async {
    await Future.delayed(const Duration(seconds: 2));
    if(!mounted){
      return;
    }
    // If we was receiving data, should set here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('did change dependencies to ${widget.item.id} (${widget.item.name})');
  }

  @override
  void didUpdateWidget(CartItemTile oldWidget) {
    loadingText = "LOADING...";
    super.didUpdateWidget(oldWidget);
    debugPrint("Did update widget to ${widget.item.id} (${widget.item.name})");
    loadingText = "";
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("Deactivating page for ${widget.item.id} (${widget.item.name})");
  }

  @override
  void dispose() {
    debugPrint('dispose do item ${widget.item.id} (${widget.item.name})');
    super.dispose();
  }
}
