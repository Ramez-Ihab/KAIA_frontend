import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/widgets/brand_bottom_sheet.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';
import 'package:kaia/features/home/presentation/widgets/brand_card.dart';

class BrandsContent extends StatelessWidget {
  const BrandsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsBloc, BrandsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(7.0, 16.5, 7.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Discover local brands', style: sectionHeader),
                const SizedBox(height: 8),
                Text(
                  '${state.filteredBrands.length} independent labels from across the MENA region',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'GlacialIndifference',
                    color: darkgreyColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Country filter chips
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Country.values.length,
                    itemBuilder: (context, index) {
                      final country = Country.values[index];
                      final isSelected = country == Country.all
                          ? state.selectedCountry == null
                          : state.selectedCountry == country;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(country.label),
                          selected: isSelected,
                          onSelected: (_) {
                            context.read<BrandsBloc>().add(
                              FilterByCountry(country == Country.all ? null : country),
                            );
                          },
                          selectedColor: primaryColor,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            fontFamily: 'GlacialIndifference',
                            fontSize: 13,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          shape: const StadiumBorder(),
                          side: BorderSide(
                            color: isSelected ? primaryColor : darkgreyColor.withValues(alpha:0.3),
                          ),
                          showCheckmark: false,
                        ),
                      );
                    },
                  ),
                ),

                // Brand list
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.filteredBrands.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => BrandBottomSheet.show(context, state.filteredBrands[index]),
                        child: BrandCard(brand: state.filteredBrands[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}