// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_inventory/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inventory/view_models/item_view.dart';
import 'package:flutter_inventory/notifiers/auth_notifier.dart';

class HomeView extends ConsumerWidget {
  final indexProvider = StateProvider<int>((ref) => 0);
  final TextEditingController itemController = TextEditingController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ref.watch(indexProvider.notifier).state == 1
              ? Text('')
              : TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Add new item to your inventory.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 16),
                                  textInput(itemController, 'Name of new item'),
                                  SizedBox(height: 8),
                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Consumer(builder: (context, ref, child) {
                                      return TextButton(
                                          onPressed: () {
                                            final itemName = itemController.text;
                                            if (itemName.isNotEmpty) {
                                              final newItem = Item(name: itemName);
                                              ref.read(itemViewModelProvider).addItem(newItem);
                                              Navigator.pop(context);
                                              itemController.clear();
                                            }
                                          },
                                          child: const Text('Add item', style: TextStyle(fontSize: 15)));
                                    }),
                                    SizedBox(width: 40),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        itemController.clear();
                                      },
                                      child: const Text('Close', style: TextStyle(fontSize: 15)),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          )),
                  child: Text(
                    '+ Add item',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
        ],
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(index: ref.watch(indexProvider), children: [
        Consumer(builder: (context, ref, child) {
          final itemViewModel = ref.watch(itemViewModelProvider);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: itemViewModel.items.map((item) => itemContainer(item.name, item.id)).toList(),
            ),
          );
        }),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
              final user = ref.read(authNotifierProvider.notifier).getUser();
              return Center(
                child: Column(
                  children: [
                    Icon(Icons.person_outline_rounded, size: 85),
                    SizedBox(height: 15),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "Email: ", style: TextStyle(color: Colors.black, fontSize: 16)),
                      TextSpan(
                        text: user?.email,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                      )
                    ])),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => ref.read(authNotifierProvider.notifier).logout(context: context),
                      child: Text('Logged out', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              );
            }),
          ],
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          currentIndex: ref.watch(indexProvider),
          onTap: (index) {
            ref.read(indexProvider.notifier).state = index;
          }),
    );
  }
}

Widget textInput(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(8))),
  );
}

Widget itemContainer(String itemName, String itemId) {
  final TextEditingController editItemController = TextEditingController();

  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 0.5))),
    child: Row(
      children: [
        Expanded(
          child: Text(
            itemName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(width: 15),
        Consumer(
          builder: (context, ref, child) => GestureDetector(
            onTap: () {
              editItemController.text = itemName;
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Edit item',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16),
                              textInput(editItemController, ''),
                              SizedBox(height: 8),
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Consumer(builder: (context, ref, child) {
                                  return TextButton(
                                      onPressed: () {
                                        final editedItem = editItemController.text;
                                        if (editedItem.isNotEmpty) {
                                          final newItemName = Item(name: editedItem);
                                          ref.read(itemViewModelProvider).editItem(itemId, newItemName);
                                          Navigator.pop(context);
                                          editItemController.clear();
                                        }
                                      },
                                      child: const Text('Edit item', style: TextStyle(fontSize: 15)));
                                }),
                                SizedBox(width: 40),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    editItemController.clear();
                                  },
                                  child: const Text('Close', style: TextStyle(fontSize: 15)),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ));
            },
            child: Icon(
              Icons.edit,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 15),
        Consumer(
          builder: (context, ref, child) => GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Do you want delete this item?',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16),
                              Text(itemName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                              SizedBox(height: 8),
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Consumer(builder: (context, ref, child) {
                                  return TextButton(
                                      onPressed: () {
                                        ref.read(itemViewModelProvider).removeItem(itemId);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete', style: TextStyle(fontSize: 15)));
                                }),
                                SizedBox(width: 40),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close', style: TextStyle(fontSize: 15)),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ));
            },
            child: Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}
