import 'package:bkid_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class RestrictionsPage extends StatefulWidget {
  @override
  _RestrictionsPageState createState() => _RestrictionsPageState();
}

class _RestrictionsPageState extends State<RestrictionsPage> {
  bool enableRestrictions = true;
  bool fractionToSaving = true;
  bool allowOnlinePayment = true;
  bool foodAndDrinks = true;
  bool entertainment = false;
  bool shopping = true;

  List<String> categories = ['Food & Drinks', 'Entertainment', 'Shopping'];
  List<String> restrictedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Restrictions', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Enable Restrictions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: CupertinoSwitch(
                value: enableRestrictions,
                onChanged: (value) {
                  setState(() {
                    enableRestrictions = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
            Divider(),
            _buildInputField('Daily spending limits', 'amount... KD', enableRestrictions),
            SizedBox(height: 16),
            _buildCardBlockRow(enableRestrictions),
            SizedBox(height: 16),
            _buildInputField('Saving limits account', 'amount... KD', enableRestrictions),
            SizedBox(height: 16),
                       _buildToggle('Allow online payment', allowOnlinePayment, enableRestrictions, (value) {
              setState(() {
                allowOnlinePayment = value;
              });
            }),
           
            _buildToggle('Fraction to saving', fractionToSaving, enableRestrictions, (value) {
              setState(() {
                fractionToSaving = value;
              });
            }),
            SizedBox(height: 16),
            _buildCategoryRestrictions(enableRestrictions),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: enableRestrictions ? () {
                context.pop();
              } : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, bool enabled) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildCardBlockRow(bool enabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCardBlockButton('Block Card', Colors.red, enabled),
        _buildCardBlockButton('Unblock Card', Colors.green, enabled),
      ],
    );
  }

  Widget _buildCardBlockButton(String label, Color color, bool enabled) {
    return ElevatedButton(
      onPressed: enabled ? () {} : null,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: enabled ? color : Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildToggle(String title, bool value, bool enabled, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: enabled ? Colors.black : Colors.grey),
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: Colors.green,
      ),
    );
  }

  Widget _buildCategoryRestrictions(bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Restrictions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: enabled ? Colors.black : Colors.grey),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: null,
          hint: Text('Select category'),
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: enabled
              ? (String? newValue) {
                  if (newValue != null && !restrictedCategories.contains(newValue)) {
                    setState(() {
                      restrictedCategories.add(newValue);
                    });
                  }
                }
              : null,
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: restrictedCategories.map((String category) {
            return Chip(
              label: Text(category),
              deleteIcon: Icon(Icons.close),
              onDeleted: () {
                setState(() {
                  restrictedCategories.remove(category);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}