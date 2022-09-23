import 'dart:convert';

import 'package:finmap_task/app/data/models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxBool isDataLoading = false.obs;

  List<Products> allProducts = [];

  RxList<Products> filteredProducts = RxList();

  RxString dropDownInitValue = "title".obs;

  List dropDownList = ["title", "catogery", "rating"];

  @override
  void onInit() async {
    await fetchProducts();
    filteredProducts.value = allProducts;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchProducts() async {
    isDataLoading.value = true;

    final url = Uri.parse("https://dummyjson.com/products");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['products'];

        data.forEach((element) {
          allProducts.add(Products.fromJson(element));
        });
      } else {
        isDataLoading.value = false;
        return;
      }
    } catch (error) {
      throw error;
    }
    isDataLoading.value = false;
  }
}
