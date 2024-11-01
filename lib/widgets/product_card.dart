import 'package:catalogo_N2/views/product_form_view.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductViewModel viewModel;

  ProductCard({required this.product, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => viewModel.deleteProduct(product.id),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductFormView(product: product)),
          );
        },
      ),
    );
  }
}
//feito