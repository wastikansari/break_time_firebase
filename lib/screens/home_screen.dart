import 'package:break_time/widget/bottom_sheet.dart';
import 'package:break_time/widget/break_end_widget.dart';
import 'package:break_time/widget/break_timer_widget.dart';
import 'package:break_time/widget/top_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/break_provider.dart';
import '../providers/auth_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasFetchedData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
      final breakProvider = Provider.of<BreakProvider>(context, listen: false);
      if (authProvider.user != null && !_hasFetchedData && !breakProvider.isLoading) {
        breakProvider.fetchBreakData(authProvider.user!.uid);
        _hasFetchedData = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final breakProvider = Provider.of<BreakProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const TopSection(),
                Expanded(child: Container(color: Colors.white)),
              ],
            ),
            Center(
              child: breakProvider.isLoading
                  ? const CircularProgressIndicator()
                  : _buildCurrentState(context, isSmallScreen, () {
                      _showBottomSheets(context, breakProvider);
                    }),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheets(BuildContext context, BreakProvider breakProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ConfirmationBottomSheet(
          endNowTap: () async {
            final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
            if (authProvider.user != null) {
              await breakProvider.endBreakEarly(authProvider.user!.uid);
            }
          },
        );
      },
    );
  }

  Widget _buildCurrentState(BuildContext context, bool isSmallScreen, Function() onTap) {
    final breakProvider = Provider.of<BreakProvider>(context);
    switch (breakProvider.state) {
      case BreakState.active:
        return BreakTimerWidget(isSmallScreen: isSmallScreen, onTap: onTap);
      case BreakState.ended:
        return const BreakEndedWidget();
      default:
        return Container();
    }
  }
}