import 'package:flutter/material.dart';
import 'package:kan_lazim/core/constants.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/padding_borders.dart';

Container bloodTopContainer({required BuildContext context, required Widget child}) {
  return Container(
    alignment: Alignment.center,
    height: context.deviceHeight * 0.22,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Color(0xffe8315b)),
    child: Row(
      children: [
        child,
        const Padding(
          padding: PaddingBorderConstant.paddingOnlyRightHigh,
          child: Icon(
            Icons.water_drop_rounded,
            color: Colors.white,
            size: 60,
          ),
        )
      ],
    ),
  );
}

class SearchCityAndState extends StatefulWidget {
  final Function(String? selectedCity)? selectedCity;
  final Function(String? selectedDistrict)? selectedDistrict;
  final bool isSearchCity;
  final String? city;

  const SearchCityAndState({super.key, this.selectedCity, this.selectedDistrict, required this.isSearchCity, this.city});

  @override
  State<SearchCityAndState> createState() => SearchCityAndStateState();
}

class SearchCityAndStateState extends State<SearchCityAndState> {
  List<String> _filteredCities = ProjectConstants.cityDistricts.keys.toList();
  List<String> _filteredDistricts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!widget.isSearchCity && widget.city != null) {
      _filteredDistricts = ProjectConstants.cityDistricts[widget.city]!;
      _searchController.addListener(() {
        filterDistricts();
      });
    } else {
      _searchController.addListener(() {
        filterCities();
      });
    }
  }

  void filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCities = ProjectConstants.cityDistricts.keys.where((city) => city.toLowerCase().contains(query)).toList();
    });
  }

  void filterDistricts() {
    final query = _searchController.text.toLowerCase();
    debugPrint("quesry: $query");
    setState(() {
      _filteredDistricts =
          ProjectConstants.cityDistricts[widget.city]!.where((district) => district.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.85,
      child: Column(
        children: [
          Padding(
            padding: PaddingBorderConstant.paddingAllHigh,
            child: SearchBar(
              controller: _searchController,
              hintText:
                  "${widget.isSearchCity ? 'Şehir' : 'İlçe'} adı girin ${!widget.isSearchCity ? '(${widget.city})' : ''}",
              trailing: const [Icon(Icons.search)],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.isSearchCity ? _filteredCities.length : _filteredDistricts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.isSearchCity ? _filteredCities[index] : _filteredDistricts[index]),
                  onTap: () {
                    setState(() {
                      if (widget.isSearchCity) {
                        widget.selectedCity!.call(_filteredCities[index]);
                      } else {
                        widget.selectedDistrict!.call(_filteredDistricts[index]);
                      }
                      Navigator.pop(context);
                      _searchController.clear();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
