import 'package:break_time/providers/auth_provider.dart';
import 'package:break_time/utiles/constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/custom_text.dart';
import '../widget/size_box.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  Future<void> _logout(BuildContext context) async {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    await authProvider.logout();
    Navigator.pushReplacementNamed(context, Constants.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final user = authProvider.user;

    return Container(
      width: 393,
      height: 279,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
                width: 393,
                height: 279,
                decoration: const BoxDecoration(color: Color(0xFF314A71))),
          ),
          Positioned(
            left: -277,
            top: -299,
            child: Container(
              width: 616,
              height: 627,
              decoration: const ShapeDecoration(
                  color: Color(0xFF38537C), shape: OvalBorder()),
            ),
          ),
          Positioned(
            left: -148,
            top: -167,
            child: Container(
              width: 389,
              height: 396,
              decoration: const ShapeDecoration(
                  color: Color(0xFF3E5D8B), shape: OvalBorder()),
            ),
          ),
          Positioned(
            left: -70,
            top: -88,
            child: Container(
              width: 233,
              height: 237,
              decoration: const ShapeDecoration(
                  color: Color(0xFF436495), shape: OvalBorder()),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: Colors.white),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, Constants.profileRoute);
                              },
                              child: const Icon(Icons.person,
                                  color: Colors.white)),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () => _logout(context),
                            child:
                                const Icon(Icons.logout, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Height(15),
                  CustomText(
                    text: "Hi, ${user?.username ?? 'User'}!",
                    color: Colors.white,
                    fontweights: FontWeight.w400,
                  ),
                  CustomText(
                    text: "You are on break!",
                    color: Colors.white,
                    size: 20,
                    fontweights: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
