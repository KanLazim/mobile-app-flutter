// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/useful_functions.dart';
import 'package:kan_lazim/models/request_model.dart';
import 'package:kan_lazim/models/user_model.dart';
import 'package:kan_lazim/screens/global_widgets.dart';
import 'package:kan_lazim/services/firebase_service.dart';

class BloodDoners extends StatefulWidget {
  const BloodDoners({
    super.key,
    required this.model,
  });

  final UserModel model;

  @override
  State<BloodDoners> createState() => _BloodDonersState();
}

class _BloodDonersState extends State<BloodDoners> {
  late String _selectedCity;
  @override
  void initState() {
    _selectedCity = widget.model.city ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            bloodTopContainer(
                context: context,
                child: Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        _selectedCity ?? "",
                        style: context.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      leading: const Icon(
                        Icons.share_location,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextButton.icon(
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SearchCityAndState(
                                    isSearchCity: true,
                                    selectedCity: (selectedCity) {
                                      setState(() {
                                        _selectedCity = selectedCity ?? "";
                                      });
                                    },
                                  ));
                        },
                        label: Text(
                          "Şehir değiştir",
                          style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
                        ))
                  ],
                ))),
            Expanded(
              child: SizedBox(
                width: context.deviceWidth * 0.9,
                child: FutureBuilder<List<RequestModel>?>(
                    future: FirebaseService().getRequests(_selectedCity),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return _noNeedBlood();
                      } else if (snapshot.hasData) {
                        final items = snapshot.data;
                        if (items?.isEmpty ?? true) {
                          return _noNeedBlood();
                        } else {
                          return ListView.builder(
                            itemCount: items?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final item = items![index];
                              return RequestCard(item: item, isOwnerPage: false);
                            },
                          );
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _noNeedBlood() => Center(
          child: Text(
        "Kan İhtiyacı Yok".toUpperCase(),
        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
      ));
}
