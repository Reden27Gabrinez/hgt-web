import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_app/views/screens/category_page.dart';
import 'package:my_app/views/screens/add_remove_products.dart';
import 'package:my_app/views/screens/add_remove_promo.dart';
import 'package:my_app/views/screens/customer_feedback.dart';
import 'package:my_app/views/screens/dashboard.dart';
import 'package:my_app/views/screens/completed_orders.dart';
import 'package:my_app/views/screens/messages.dart';
import 'package:my_app/views/screens/payment_section.dart';
import 'package:my_app/views/screens/users.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _controller = PageController();

  NavigationRailLabelType labelType = NavigationRailLabelType.selected;

  @override
  void initState() {
    _controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    groupAlignment: 4,
                    elevation: 10,
                    minWidth: 120,
                    backgroundColor: Colors.grey[300],
                    unselectedIconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                    selectedIconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 31, 31, 176),
                    ),
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                        _controller.jumpToPage(_selectedIndex);
                      });
                    },
                    labelType: labelType,
                    destinations: <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.dashcube,
                          size: 35,
                        ),
                        label: Text(
                          'Dashboard',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.cart_shopping,
                          size: 35,
                        ),
                        label: Text(
                          'Orders & Payment',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.box,
                          size: 35,
                        ),
                        label: Text(
                          'Add/Remove Category',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.store,
                          size: 35,
                        ),
                        label: Text(
                          'Add/Remove Product',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.rectangle_ad,
                          size: 35,
                        ),
                        label: Text(
                          'Add/Remove Promo',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.message,
                          size: 35,
                        ),
                        label: Text(
                          'Messages',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.user,
                          size: 35,
                        ),
                        label: Text(
                          'Users',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(
                          FontAwesome.comment,
                          size: 35,
                        ),
                        label: Text(
                          'Customer Feedback',
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 31, 31, 176),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 7,
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: const [
                  DashboardPage(),
                  PaymentSection(),
                  CategoryPage(),
                  AddorRemoveProductsPage(),
                  AddRemovePromo(),
                  MessagesPage(),
                  ViewUserPage(),
                  CustomerFeedbackPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
