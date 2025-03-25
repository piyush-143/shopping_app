import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/repository/shopping_repository.dart';
import 'package:shopping_app/ui_helper/ui_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/view_model/cart_view_model.dart';

import 'cart_view.dart';

class CatalogueView extends StatelessWidget {
  const CatalogueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: _buildProductGrid(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      toolbarHeight: 70,
      title: const Text("Catalogue"),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartView()),
                ),
            child: badges.Badge(
              badgeContent: UiHelper.customText(
                text: context
                    .watch<CartViewModel>()
                    .totalQuantity
                    .toStringAsFixed(0),
                size: 8,
                color: Colors.white,
                weight: FontWeight.w600,
              ),
              position: badges.BadgePosition.custom(top: -10, end: -5),
              badgeStyle: badges.BadgeStyle(
                badgeColor: AppColors.buttonBgColor,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return FutureBuilder(
      future: ShoppingRepository().getShoppingApi(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: AppColors.buttonBgColor,
            ),
          );
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 240,
              mainAxisSpacing: 8,
            ),
            itemCount: snapshot.data!.products!.length,
            itemBuilder:
                (context, index) => _buildGridTile(
                  context,
                  name: snapshot.data!.products![index].title!,
                  brand: snapshot.data!.products![index].brand ?? "Null",
                  imageUrl: snapshot.data!.products![index].thumbnail!,
                  price: snapshot.data!.products![index].price!,
                  discount: snapshot.data!.products![index].discountPercentage!,
                ),
          );
        }
      },
    );
  }

  Widget _buildGridTile(
    BuildContext context, {
    required String name,
    String? brand,
    required String imageUrl,
    required double price,
    required double discount,
  }) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 140,
            child: Stack(
              children: [
                Image.network(imageUrl, fit: BoxFit.contain),
                _buildAddButton(
                  context,
                  onPressed:
                      () => context.read<CartViewModel>().addToCart(
                        name: name,
                        brand: brand,
                        price: price,
                        discount: discount,
                        imageUrl: imageUrl,
                      ),
                ),
              ],
            ),
          ),
          const Divider(height: 0, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: UiHelper.pricingColumn(
              name: name,
              brand: brand,
              price: price,
              discount: discount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            fixedSize: const Size(75, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(color: Colors.black38, width: 0.5),
          ),
          child: UiHelper.customText(
            text: "Add",
            size: 10,
            color: AppColors.buttonBgColor,
          ),
        ),
      ),
    );
  }
}
