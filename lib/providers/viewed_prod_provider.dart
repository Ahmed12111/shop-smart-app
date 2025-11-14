import 'package:flutter/material.dart';
import 'package:shop_smart_app/models/viewed_prod_model.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getviewedProdItems {
    return _viewedProdItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(id: const Uuid().v4(), productId: productId),
    );

    notifyListeners();
  }
}
