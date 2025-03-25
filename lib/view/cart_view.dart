import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/view_model/cart_view_model.dart';

import '../ui_helper/ui_helper.dart';
import '../utils/colors.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body:
          cartViewModel.cartList.isEmpty
              ? _buildEmptyCartMessage()
              : _buildCartItems(context, cartViewModel),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      toolbarHeight: 70,
      title: const Text("Cart"),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    );
  }

  Widget _buildEmptyCartMessage() {
    return Center(
      child: UiHelper.customText(
        text: "Empty Cart !!!\nAdd Some Products to cart",
        size: 15,
        color: AppColors.buttonBgColor,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartViewModel cartViewModel) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 12,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartViewModel.cartList.length,
                itemBuilder:
                    (ctx, index) =>
                        _buildCartItem(context, cartViewModel, index),
              ),
            ),
            Expanded(flex: 2, child: SizedBox()),
          ],
        ),
        _buildCheckoutTile(context, cartViewModel),
      ],
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartViewModel cartViewModel,
    int index,
  ) {
    final item = cartViewModel.cartList[index];
    return Container(
      height: 120,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item["ImageUrl"].toString()),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const VerticalDivider(thickness: 0.5, width: 0),
              const SizedBox(width: 7),
              UiHelper.pricingColumn(
                name: item["Name"],
                price: item["Price"] * item["Quantity"],
                brand: item["Brand"],
                discount: item["Discount"],
              ),
            ],
          ),
          Positioned(
            right: 15,
            bottom: 10,
            child: _buildQuantityButton(context, index),
          ),
          _buildRemoveButton(context, index),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(BuildContext context, int index) {
    return Container(
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                () => context.read<CartViewModel>().decrementQuantity(index),
            icon: const Icon(Icons.remove, color: Colors.black, size: 20),
          ),
          UiHelper.customText(
            text:
                context
                    .watch<CartViewModel>()
                    .cartList[index]["Quantity"]
                    .toString(),
            size: 12,
            color: AppColors.buttonBgColor,
          ),
          IconButton(
            onPressed:
                () => context.read<CartViewModel>().incrementQuantity(index),
            icon: const Icon(Icons.add, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutTile(BuildContext context, CartViewModel cartViewModel) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiHelper.customText(text: "Amount Price", size: 12),
                UiHelper.customText(
                  text: '₹${cartViewModel.totalAmount.toStringAsFixed(2)}',
                  size: 20,
                ),
              ],
            ),
            _buildCheckoutButton(
              quantity: cartViewModel.totalQuantity.toStringAsFixed(0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton({required String quantity}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 45),
        elevation: 0.5,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.buttonBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.customText(
            text: "Check Out ",
            size: 11,
            color: Colors.white,
            letterSpacing: 0,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 9,
            child: UiHelper.customText(
              text: quantity,
              size: 12,
              color: AppColors.buttonBgColor,
              letterSpacing: 0,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context, int index) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () => context.read<CartViewModel>().removeFromCart(index),
        icon: Icon(Icons.delete_forever, color: AppColors.buttonBgColor),
      ),
    );
  }
}
