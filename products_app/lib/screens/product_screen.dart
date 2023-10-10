import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:products_app/models/models.dart';
import 'package:products_app/providers/providers.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/ui/custom_input_decoration.dart';
import 'package:products_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final Product selectedProduct = productService.selectedProduct!;

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(selectedProduct),
      child: _ProductScreenBody(
        selectedProduct: selectedProduct, 
        productService: productService,
      ),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final Product selectedProduct;
  final ProductService productService;
  
  const _ProductScreenBody({
    required this.selectedProduct, required this.productService,
  });

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(imageUrl: selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 40, color: Colors.white,)
                  )
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera
                      );
                      if (pickedFile == null) {
                        return;
                      }
                      productService.updateSelectedProductImage(pickedFile.path);
                    }, 
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,)
                  )
                ),
              ],
            ),
            _ProductForm(selectedProduct),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isSaving 
        ? null 
        : () async {
          if (!productFormProvider.isValidForm()) return;

          final String? uploadedImageUrl = await productService.uploadImage();
          if (uploadedImageUrl != null) {
            productFormProvider.product.picture = uploadedImageUrl;
          }

          await productService.saveProduct(productFormProvider.product);     
        },
        child: productService.isSaving 
        ? const CircularProgressIndicator(color: Colors.white,)
        : const Icon(Icons.save_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _ProductForm extends StatelessWidget {
  final Product? selectedProduct;

  const _ProductForm(this.selectedProduct);

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productFormProvider.formStateKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre del producto es requerido';
                  }
                },
                decoration: CustomInputDecoration.authInputDecoration(
                  hintText: 'Nombre del producto', 
                  labelText: 'Nombre:'
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                initialValue: product.price.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  double.tryParse(value) == null 
                  ? product.price = 0
                  : product.price = double.parse(value);
                }, 
                keyboardType: TextInputType.number,
                decoration: CustomInputDecoration.authInputDecoration(
                  hintText: '\$150', 
                  labelText: 'Precio:',
                ),
              ),
              const SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: selectedProduct!.available, 
                title: const Text('Disponible'),
                activeColor: const Color(0xffe76f51),
                onChanged: productFormProvider.updateAvailability
              ),
              const SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 5),
        blurRadius: 5
      )
    ]
  );
}
