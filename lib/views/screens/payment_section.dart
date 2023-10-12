import 'package:flutter/material.dart';
import 'package:my_app/views/screens/completed_orders.dart';
import 'package:my_app/views/screens/confirmed_orders.dart';
import 'package:my_app/views/screens/on_delivery_orders.dart';
import 'package:my_app/views/screens/pending_order.dart';

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/images/hgt_logo.png',
              scale: 10,
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Pending',
                icon: Icon(Icons.pending),
              ),
              Tab(
                text: 'Confirmed',
                icon: Icon(Icons.check),
              ),
              Tab(
                text: 'On-Delivery',
                icon: Icon(Icons.electric_scooter),
              ),
              Tab(
                text: 'Delivered',
                icon: Icon(Icons.check_box),
              ),
            ]),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const TabBarView(children: [
              PendingPage(),
              ConfirmedPage(),
              OnDeliveryPage(),
              CompletedOrdersPage(),
            ]),
          ),
        ),
      ),
    );
  }
}
