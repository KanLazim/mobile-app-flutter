import 'package:flutter/material.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/useful_functions.dart';
import 'package:kan_lazim/services/firebase_service.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Taleplerim"),
      ),
      body: Center(
        child: SizedBox(
          width: context.deviceWidth * 0.9,
          child: FutureBuilder(
            future: FirebaseService().getMyRequest(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Bir hata olustu"));
              } else if (snapshot.hasData) {
                final items = snapshot.data;
                if (items?.isEmpty ?? true) {
                  return Center(
                      child: Text("Taleplerim Yok",
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          )));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final item = items![index];
                      debugPrint(item.docId);
                      return RequestCard(
                        item: item,
                        isOwnerPage: true,
                        isRemoved: (state) {
                          if (state) {
                            setState(() {});
                          }
                        },
                      );
                    },
                  );
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
