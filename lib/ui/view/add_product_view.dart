import 'package:flutter/material.dart';
import 'package:todoappvb/core/model/Product.dart';
import 'package:todoappvb/core/service.dart';

// ignore: must_be_immutable
class AddProductView extends StatelessWidget {
  AddProductView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controllerName,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: const OutlineInputBorder(),
                  labelText: "Task Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bu alan boş bırakılamaz!";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: controllerPrice,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: const OutlineInputBorder(),
                  labelText: "Task Price",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bu alan boş bırakılamaz!";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: controllerImage,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: const OutlineInputBorder(),
                  labelText: "Image Url",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bu alan boş bırakılamaz!";
                  }
                  return null;
                },
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    var model = Product(
                        productName: controllerName.text,
                        imageUrl: controllerImage.text,
                        money: int.parse(controllerPrice.text));
                    await ApiService.getInstance().addProducts(model);
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(StadiumBorder())),
                  icon: const Icon(Icons.add),
                  label: const Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
