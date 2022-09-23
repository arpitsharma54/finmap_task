import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Products'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Obx(() {
            return controller.isDataLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                              ),
                              onChanged: (value) {
                                if (controller.dropDownInitValue.value ==
                                    "title") {
                                  controller.filteredProducts.value = controller
                                      .allProducts
                                      .where((element) => element.title!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                } else if (controller.dropDownInitValue.value ==
                                    "catogery") {
                                  controller.filteredProducts.value = controller
                                      .allProducts
                                      .where((element) => element.category!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                } else {
                                  controller.filteredProducts.value = controller
                                      .allProducts
                                      .where((element) => element.rating!
                                          .toString()
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                }
                              },
                            ),
                          ),
                          Obx(
                            () => DropdownButton(
                                value: controller.dropDownInitValue.value,
                                items: controller.dropDownList.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  controller.dropDownInitValue.value =
                                      v.toString();
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.76,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return product(index);
                          },
                          itemCount: controller.filteredProducts.length,
                        ),
                      ),
                    ],
                  );
          }),
        ));
  }

  Widget product(index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Get.toNamed("/product-detail");
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      height: 80,
                      width: 80,
                      image: NetworkImage(
                          controller.filteredProducts[index].thumbnail!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.filteredProducts[index].title!.length > 28
                          ? controller.filteredProducts[index].title!
                                  .substring(0, 27) +
                              "...."
                          : controller.filteredProducts[index].title!),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$ ${controller.filteredProducts[index].price!.toString()}",
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              Text("Rating: ${controller.filteredProducts[index].rating!}")
            ],
          ),
        ),
      ),
    );
  }
}
