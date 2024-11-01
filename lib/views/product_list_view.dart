import 'package:catalogo_N2/models/product.dart';
import 'package:flutter/material.dart';
import '../viewmodels/product_viewmodel.dart';
import '../widgets/product_card.dart';
import 'product_form_view.dart';

class ProductListView extends StatelessWidget {
  final ProductViewModel viewModel = ProductViewModel();

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Produtos')),
      body: StreamBuilder<List<Product>>(
        stream: viewModel.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar produtos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto disponível'));
          } else {
            return ListView(
              children: snapshot.data!.map((product) => ProductCard(product: product, viewModel: viewModel)).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductFormView())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
//feito