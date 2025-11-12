import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_smart_app/models/product_model.dart';

class FirebaseUploader {
  static Future<void> uploadProducts(List<ProductModel> products) async {
    final firestore = FirebaseFirestore.instance;
    final productsCollection = firestore.collection('products');

    for (var product in products) {
      await productsCollection.doc(product.productId).set({
        'productId': product.productId,
        'productTitle': product.productTitle,
        'productPrice': product.productPrice,
        'productCategory': product.productCategory,
        'productDescription': product.productDescription,
        'productImage': product.productImage,
        'productQuantity': product.productQuantity,
      });
    }
  }
}
