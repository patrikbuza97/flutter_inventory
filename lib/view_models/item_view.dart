import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inventory/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final itemViewModelProvider = ChangeNotifierProvider<ItemViewModel>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).value;
  return ItemViewModel(sharedPreferences);
});

class ItemViewModel extends ChangeNotifier {
  SharedPreferences? storage;
  List<Item> _items = [];
  List<Item> get items => _items;

  ItemViewModel(this.storage) {
    if (storage != null) {
      loadItems();
    }
  }

  String _generateUniqueId() {
    return UniqueKey().toString();
  }

  Future<void> loadItems() async {
    List<String>? itemListString = storage!.getStringList('itemList');
    if (itemListString != null) {
      _items = itemListString.map((item) => Item.fromJson(json.decode(item))).toList();
    }
  }

  void addItem(Item item) async {
    final newItem = Item(id: _generateUniqueId(), name: item.name);
    _items.add(newItem);
    await saveItems();
    notifyListeners();
  }

  Future<void> saveItems() async {
    List<String> itemListString = _items.map((item) => jsonEncode(item.toJson())).toList();
    await storage!.setStringList('itemList', itemListString);
  }

  void removeItem(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);

    if (index != -1) {
      _items.removeAt(index);
      saveItems();
      notifyListeners();
    }
  }

  void editItem(String itemId, Item newItem) {
    final index = _items.indexWhere((item) => item.id == itemId);

    if (index != -1) {
      _items[index] = newItem;
      saveItems();
      notifyListeners();
    }
  }
}
