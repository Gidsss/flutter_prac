import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/admin/admindashboard.dart';
import 'package:project_v/screens/admin/calendar/calendarscreen.dart';
import 'package:project_v/screens/admin/coupons/couponmanagement.dart';
import 'package:project_v/screens/admin/products/productmanagement.dart';
import 'package:project_v/screens/admin/profile/adminprofilescreen.dart';
import 'package:project_v/screens/main/chatscreen.dart';
import '../../screens/main/notificationsscreen.dart';

class AdminHeaderFooter extends StatefulWidget {
  final Widget? body;
  final bool hasDrawer;
  final String? title;
  final List<bool> buttonStatus;
  final BuildContext context;
  final bool mainHeader;
  final bool hasFloatbar;
  final Widget? floatbar;
  final bool isProfileFloatbar;
  final Widget? profileFloatbar;

  const AdminHeaderFooter({
    super.key,
    this.floatbar,
    this.hasFloatbar = false,
    this.mainHeader = true,
    this.hasDrawer = false,
    required this.body,
    required this.title,
    required this.context,
    required this.buttonStatus,
    this.isProfileFloatbar = false,
    this.profileFloatbar,
  });

  @override
  State<AdminHeaderFooter> createState() => _AdminHeaderFooterState();
}

class _AdminHeaderFooterState extends State<AdminHeaderFooter>
    with TickerProviderStateMixin {
  late TabController _scheduleTabController;
  late TabController _ordersTabController;
  late TabController _profileTabController;

  @override
  void initState() {
    super.initState();
    _scheduleTabController = TabController(length: 2, vsync: this);
    _ordersTabController = TabController(length: 2, vsync: this);
    _profileTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scheduleTabController.dispose();
    _ordersTabController.dispose();
    _profileTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.mainHeader
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                buildmainHeader(context),
                Expanded(
                  child: Container(
                    child: widget.body,
                  ),
                ),
                buildFooter(widget.buttonStatus, widget.context),
              ],
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                title: Image.asset(
                  AppConstants.logoImagePath,
                  width: 40,
                  height: 40,
                ),
                bottom: widget.title == "Schedule"
                    ? TabBar(
                        controller: _scheduleTabController,
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(text: "Upcoming"),
                          Tab(text: "Completed"),
                        ],
                      )
                    : widget.title == "Orders"
                        ? TabBar(
                            controller: _ordersTabController,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: "Active"),
                              Tab(text: "Completed"),
                            ],
                          )
                        : TabBar(
                            controller: _profileTabController,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: "Profile"),
                              Tab(text: "Settings"),
                            ],
                          ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: widget.title == "Schedule"
                          ? _scheduleTabController
                          : widget.title == "Orders"
                              ? _ordersTabController
                              : _profileTabController,
                      children: [
                        Container(
                          child: widget.body,
                        ),
                        Container(
                          child: widget.body,
                        ),
                      ],
                    ),
                  ),
                  _buildSpacing(), // Call the method to build spacing widget
                  buildFooter(widget.buttonStatus, widget.context),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: widget.hasFloatbar
                  ? (widget.isProfileFloatbar
                      ? widget.profileFloatbar
                      : widget.floatbar)
                  : null,

            ),
          );
  }

  Widget _buildSpacing() {
    if (widget.title == "Schedule") {
      return const SizedBox(height: 55); // Height for Schedule
    } else {
      return const SizedBox(height: 0); // Height for Orders and Profile
    }
  }
}
  


  Widget buildmainHeader(BuildContext context) {
    return Material(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ], color: Colors.white),
          child: Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppConstants.logoImagePath,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 8),
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Valdopeña",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              Text("Opticals",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                const SizedBox(width: 100),
                Row(
                  children: [
                    headerIconButton(context, Icons.mark_unread_chat_alt_outlined, const ChatScreen()),
                    const SizedBox(width: 6),
                    headerIconButton(context, Icons.notifications_outlined, const NotificationsScreen()),
                    const SizedBox(width: 6),
                  ],
                ),
              ],
            ),
          ),
          )))
    );
  }

  Widget buildFooter(List<bool> buttonStatus, BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonStatus[0]
                ? buildButton("Home", Icons.home, buttonStatus[0], () {})
                : buildButton("Home", Icons.home_outlined, buttonStatus[0], () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminDashboardScreen()));
            }),
            buttonStatus[1]
                ? buildButton("Products", Icons.local_offer, buttonStatus[1], () {})
                : buildButton(
                "Products", Icons.local_offer_outlined, buttonStatus[1], () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductsScreen()));
            }),
            buttonStatus[2]
                ? buildButton(
                "Coupons", Icons.star, buttonStatus[2], () {})
                : buildButton(
                "Coupons", Icons.star_border_outlined, buttonStatus[2],
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CouponsScreen()));
                }),
            buttonStatus[3]
                ? buildButton(
                "Calendar", Icons.calendar_month, buttonStatus[3], () {})
                : buildButton(
                "Calendar", Icons.calendar_month_outlined, buttonStatus[3],
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalendarScreen()));
                }),
            buttonStatus[4]
                ? buildButton(
                "Profile", Icons.account_circle, buttonStatus[4], () {})
                : buildButton(
                "Profile", Icons.account_circle_outlined, buttonStatus[4],
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminProfileScreen()));
                }),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      String label, IconData icon, bool isScreen, void Function() navigate) {
    return Expanded(
      // If isScreen is true, the button has a top border and different background color. Else button no border and white bg color.
      child: isScreen
          ? Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 1.5))),
        child: TextButton(
            onPressed: () {
              navigate();
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFF4F4F4))),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Icon(
                  icon,
                  size: 34,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  label,
                  style:
                  const TextStyle(fontSize: 13, color: Colors.black),
                ),
              ],
            )),
      )
          : TextButton(
          onPressed: () {
            navigate(); // Pass argument here to Navigate to screen Logic which is to follow
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white)),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Icon(
                icon,
                size: 34,
                color: Colors.black,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
            ],
          )),
    );
  }

Widget headerIconButton( BuildContext context, IconData icon, Widget page) {
  return IconButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    },
    icon: Icon(
      icon,
      size: 30,
      color: Colors.black,
    ),
    padding: const EdgeInsets.all(0),
    constraints: const BoxConstraints(),
  );
}

