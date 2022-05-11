import 'package:bunyaad/Model/order.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';

import '../Model/Style.dart';

class BuyerOrder extends StatefulWidget {
  Order order;

  BuyerOrder({required this.order});

  @override
  _BuyerOrderState createState() => _BuyerOrderState();
}

class _BuyerOrderState extends State<BuyerOrder> {
  Widget displayMessage(bool isMe, String message) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Style.defaultHeadingColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message, style: const TextStyle(color: Colors.white)),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Bunyaad",
          style: Style.heading(),
        ),
        actions: [
          ClipOval(
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.switch_account_rounded,
                  color: Colors.black87,
                  size: 32,
                )),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  "Order Details",
                  style: TextStyle(fontSize: 28),
                )),
            const SizedBox(
              height: 24,
            ),
            displayMessage(false, "Order Placed"),
            widget.order.confirm == "confirm"
                ? displayMessage(false, "Order Confirmed")
                : const SizedBox.shrink(),
            widget.order.confirm == "cancel"
                ? displayMessage(false, "Order Cancel")
                : const SizedBox.shrink(),
            widget.order.isComplete == "complete"
                ? displayMessage(false, "Order Completed")
                : const SizedBox.shrink(),
            const SizedBox(
              height: 24,
            ),
            widget.order.isComplete == "complete"
                ? ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: ()async {
                       CustomWidget.showReviewBox(context, widget.order.productId,widget.order.buyerName );
                    },
                    child: Text("Review"))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
