import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class CurrencyPicker extends StatefulWidget {
  const CurrencyPicker({Key? key}) : super(key: key);

  @override
  _CurrencyPickerState createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(title:_buildCurrencyPickerDropdown(true)),
    );
  }
  _buildCurrencyPickerDropdown(bool filtered) => Row(
    children: <Widget>[
      CurrencyPickerDropdown(
        initialValue: 'INR',
        itemBuilder: _buildCurrencyDropdownItem,
        itemFilter: filtered
            ? (c) =>
            ['INR', 'CAD', 'USD', 'CHF', 'EUR'].contains(c.currencyCode)
            : null,
        onValuePicked: (Country? country) {
          print("${country?.name}");
        },
      ),
    ],
  );

  Widget _buildCurrencyDropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text("${country.currencyCode}"),
      ],
    ),
  );
}

