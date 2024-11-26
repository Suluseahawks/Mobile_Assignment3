import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../databases/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FoodItem>> foodItems;

  @override
  void initState() {
    super.initState();
    _refreshFoodItems();
  }

  void _refreshFoodItems() {
    setState(() {
      foodItems = DatabaseHelper.instance.getFoodItems();
    });
  }

  void _showAddFoodDialog() {
    final nameController = TextEditingController();
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Food Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Food Name"),
            ),
            TextField(
              controller: costController,
              decoration: InputDecoration(labelText: "Cost"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final cost = double.tryParse(costController.text.trim());

              if (name.isNotEmpty && cost != null && cost > 0) {
                await DatabaseHelper.instance.insertFoodItem(
                  FoodItem(name: name, cost: cost),
                );
                _refreshFoodItems();
                Navigator.of(context).pop();
              } else {
                // Show an error if input is invalid
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid input. Please try again.")),
                );
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Ordering"),
      ),
      body: FutureBuilder<List<FoodItem>>(
        future: foodItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No food items available'));
          }

          List<FoodItem> items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index].name),
                subtitle: Text("\$${items[index].cost.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFoodDialog,
        child: Icon(Icons.add),
        tooltip: "Add Food Item",
      ),
    );
  }
}
