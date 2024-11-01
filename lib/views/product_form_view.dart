import 'package:flutter/material.dart';
import '../models/product.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductFormView extends StatefulWidget {
  final Product? product;

  const ProductFormView({super.key, this.product});

  @override
  _ProductFormViewState createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final ProductViewModel viewModel = ProductViewModel();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Adicionar Produto' : 'Editar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome do produto' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe o preço' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      id: widget.product?.id ?? '',
                      name: _nameController.text,
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),
                    );
                    if (widget.product == null) {
                      await viewModel.addProduct(product);
                    } else {
                      await viewModel.updateProduct(product);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.product == null ? 'Adicionar' : 'Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//feito