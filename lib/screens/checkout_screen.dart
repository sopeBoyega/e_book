// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;

  final _shippingFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;

  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  final List<String> provinces = [
    'Abuja FCT','Lagos','Rivers','Oyo','Kano','Kaduna','Anambra','Enugu','Imo','Delta',
    'Ogun','Ondo','Osun','Edo','Akwa Ibom','Cross River','Bayelsa','Plateau','Katsina','Sokoto',
  ];

  final Map<String, List<String>> cities = {
    'Abuja FCT': ['Garki','Wuse','Maitama','Asokoro','Kubwa','Jabi'],
    'Lagos': ['Ikeja','Lekki','Victoria Island','Yaba','Surulere','Ikoyi','Ajah'],
    'Rivers': ['Port Harcourt','Obio-Akpor','Eleme'],
  };

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // SUCCESS SCREEN
    if (_currentStep == 2) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () {
            cart.clear();
            Navigator.popUntil(context, (route) => route.isFirst);
          })],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(32), decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 100)),
              const SizedBox(height: 40),
              const Text('Payment Successful!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Total Paid: ${cart.totalFormatted}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Order Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.grey[50],
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _row('Subtotal', cart.subtotalFormatted),
              _row('Shipping', cart.shippingFormatted),
              const Divider(),
              _row('Total', cart.totalFormatted, bold: true),
            ]),
          ),

          Expanded(child: _currentStep == 0 ? _shippingForm() : _paymentForm()),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep == 0) {
                  if (_shippingFormKey.currentState!.validate() && _selectedProvince != null && _selectedCity != null) {
                    setState(() => _currentStep = 1);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields'), backgroundColor: Colors.red));
                  }
                } else {
                  if (_paymentFormKey.currentState!.validate()) {
                    setState(() => _currentStep = 2);
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              child: Text(_currentStep == 0 ? 'Continue to Payment' : 'Pay ${cart.totalFormatted}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.w500)),
      Text(value, style: TextStyle(fontSize: bold ? 22 : 18, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _shippingForm() => Form(
    key: _shippingFormKey,
    child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Shipping Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      _field(_nameController, 'Full Name *'),
      _field(_phoneController, 'Phone Number *', prefix: '+234 '),
      DropdownButtonFormField<String>(
  initialValue: _selectedProvince,
  decoration: _dec('State / Province *'),
  items: provinces.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
  onChanged: (v) => setState(() {
    _selectedProvince = v;
    _selectedCity = null;
  }),
  validator: (v) => v == null ? 'Required' : null,
),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        initialValue: _selectedCity,
        decoration: _dec('City *'),
        items: _selectedProvince == null ? [] : cities[_selectedProvince]!.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: _selectedProvince != null ? (v) => setState(() => _selectedCity = v) : null,
        validator: (v) => v == null ? 'Required' : null,
      ),
      const SizedBox(height: 16),
      _field(_addressController, 'Street Address *'),
      _field(_postalController, 'Postal Code *', keyboard: TextInputType.number),
      const SizedBox(height: 40),
    ]),
  );

  Widget _paymentForm() => Form(
    key: _paymentFormKey,
    child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Payment Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 30),
      _field(_cardHolderController, 'Cardholder Name *'),
      _field(_cardNumberController, 'Card Number *', hint: '1234 5678 9012 3456', keyboard: TextInputType.number),
      Row(children: [
        Expanded(child: _field(_expiryController, 'MM/YY *')),
        const SizedBox(width: 16),
        Expanded(child: _field(_cvvController, 'CVV *', keyboard: TextInputType.number)),
      ]),
      const SizedBox(height: 60),
    ]),
  );

  Widget _field(TextEditingController c, String label, {String? hint, String? prefix, TextInputType? keyboard}) => Padding(
  padding: const EdgeInsets.only(bottom: 16),
  child: TextFormField(
    controller: c,
    keyboardType: keyboard,
    decoration: InputDecoration(
      labelText: label,
      hintText:hint,
      prefixText: prefix,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Required';
      }
      return null;
    },
  ),
);

  InputDecoration _dec(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.grey[50],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
  );
}