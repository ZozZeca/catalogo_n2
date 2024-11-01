import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductViewModel {
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> getProducts() {
    return productsCollection.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList()
    );
  }

  Future<void> addProduct(Product product) async {
    await productsCollection.add(product.toMap());
  }

  Future<void> updateProduct(Product product) async {
    await productsCollection.doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String productId) async {
    await productsCollection.doc(productId).delete();
  }
}
