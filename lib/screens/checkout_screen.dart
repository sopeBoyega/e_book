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
  int _currentStep = 0; // 0 = Shipping, 1 = Payment, 2 = Success

  final _shippingFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  // Shipping
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;

  // Payment
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  final List<String> provinces = [
    'Abuja FCT','Lagos','Rivers','Oyo','Kano','Kaduna','Anambra','Enugu','Imo','Delta',
    'Ogun','Ondo','Osun','Edo','Akwa Ibom','Cross River','Bayelsa','Plateau','Katsina','Sokoto',
  ];

  final Map<String, List<String>> cities = {
    'Abuja FCT': ['Garki', 'Wuse', 'Maitama', 'Asokoro', 'Kubwa', 'Jabi', 'Gwagwalada', 'Lugbe', 'Durumi', 'Utako'],
    'Lagos': ['Ikeja', 'Lekki', 'Victoria Island', 'Yaba', 'Surulere', 'Ajah', 'Ikoyi', 'Magodo', 'Ogba', 'Agege', 'Alimosho', 'Apapa', 'Ikorodu', 'Badagry', 'Epe'],
    'Rivers': ['Port Harcourt', 'Obio-Akpor', 'Eleme', 'Oyigbo', 'Okrika', 'Etche', 'Ikwerre', 'Emohua', 'Khana'],
    'Oyo': ['Ibadan', 'Ogbomosho', 'Iseyin', 'Oyo Town', 'Saki', 'Igboho', 'Kisi', 'Eruwa', 'Igangan'],
    'Kano': ['Kano Municipal', 'Fagge', 'Dala', 'Gwale', 'Tarauni', 'Nassarawa', 'Kumbotso', 'Ungogo', 'Dawakin Tofa'],
    'Kaduna': ['Kaduna North', 'Kaduna South', 'Zaria', 'Sabon Gari', 'Chikun', 'Kajuru', 'Giwa', 'Birnin Gwari'],
    'Anambra': ['Awka', 'Onitsha', 'Nnewi', 'Ihiala', 'Aguata', 'Idemili North', 'Idemili South', 'Ogbaru', 'Orumba North'],
    'Enugu': ['Enugu North', 'Enugu South', 'Nsukka', 'Udi', 'Nkanu West', 'Uzo Uwani', 'Ezeagu', 'Igbo Etiti'],
    'Imo': ['Owerri Municipal', 'Owerri West', 'Owerri North', 'Okigwe', 'Orlu', 'Ideato North', 'Mbaitoli', 'Ngor Okpala'],
    'Delta': ['Asaba', 'Warri', 'Sapele', 'Ughelli', 'Agbor', 'Oleh', 'Ozoro', 'Kwale', 'Abraka'],
    'Ogun': ['Abeokuta North', 'Abeokuta South', 'Ijebu Ode', 'Sagamu', 'Ifo', 'Ota', 'Ado-Odo/Ota', 'Yewa South'],
    'Ondo': ['Akure', 'Ondo Town', 'Owo', 'Ikare-Akoko', 'Okitipupa', 'Ore', 'Idanre', 'Igbokoda'],
    'Osun': ['Osogbo', 'Ile-Ife', 'Ilesa', 'Ede', 'Ikire', 'Iwo', 'Ejigbo', 'Ila Orangun'],
    'Edo': ['Benin City', 'Ekpoma', 'Auchi', 'Uromi', 'Okada', 'Irrua', 'Fugar', 'Agenebode'],
    'Akwa Ibom': ['Uyo', 'Eket', 'Ikot Ekpene', 'Abak', 'Oron', 'Ikot Abasi', 'Etinan', 'Ukanafun'],
    'Cross River': ['Calabar', 'Ogoja', 'Ikom', 'Obudu', 'Ugep', 'Akamkpa', 'Obubra', 'Bakassi'],
    'Bayelsa': ['Yenagoa', 'Sagbama', 'Ogbia', 'Nembe', 'Brass', 'Ekeremor', 'Kolokuma/Opokuma', 'Southern Ijaw'],
    'Plateau': ['Jos', 'Bukuru', 'Pankshin', 'Shendam', 'Barkin Ladi', 'Mangu', 'Bokkos', 'Wase'],
    'Katsina': ['Katsina', 'Funtua', 'Daura', 'Malumfashi', 'Dutsin-Ma', 'Kankia', 'Bakori', 'Batagarawa'],
    'Sokoto': ['Sokoto', 'Tambuwal', 'Illela', 'Gwadabawa', 'Yabo', 'Binji', 'Wurno', 'Rabah'],
  };

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // SUCCESS SCREEN
    if (_currentStep == 2) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                cart.clear();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, color: Colors.black, size: 120),
              SizedBox(height: 32),
              Text('Payment received!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text('Your order has been validated.', style: TextStyle(fontSize: 18, color: Colors.black54)),
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
      leading: const BackButton(color: Colors.black),
      title: const Text('Checkout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
      IconButton(
      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 28),
      onPressed: () {
        // This takes user back to Cart Screen
        Navigator.of(context).pop();
        },
          ),  
          const SizedBox(width: 8), // nice spacing
        ],  
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _stepIcon(Icons.local_shipping, _currentStep >= 0),
                _line(_currentStep >= 1),
                _stepIcon(Icons.credit_card, _currentStep >= 1),
                _line(false),
                _stepIcon(Icons.done, false),
              ],
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _currentStep == 0 ? 'Enter Shipping Details' : 'Select a Payment Method',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),

          Expanded(
            child: _currentStep == 0 ? _buildShippingForm() : _buildPaymentForm(),
          ),

          // Confirm Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
            ),
            child: ElevatedButton(
              onPressed: _confirmPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 8,
              ),
              child: const Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmPressed() {
    if (_currentStep == 0) {
      if (_shippingFormKey.currentState!.validate() && _selectedProvince != null && _selectedCity != null) {
        setState(() => _currentStep = 1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields'), backgroundColor: Colors.red),
        );
      }
    } else {
      if (_paymentFormKey.currentState!.validate()) {
        setState(() => _currentStep = 2);
      }
    }
  }

  Widget _stepIcon(IconData icon, bool active) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.grey[600], size: 28),
      );

  Widget _line(bool active) => Container(width: 60, height: 2, color: active ? Colors.black : Colors.grey[300]);

  // SHIPPING FORM — PERFECT SPACING
  Widget _buildShippingForm() => Form(
        key: _shippingFormKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 20),
            buildLabeledField('Full Name *', _nameController, 'Enter full name'),
            buildLabeledField('Phone Number *', _phoneController, 'Enter phone number', prefix: '+234 '),
            buildLabeledDropdown('Select Province', provinces, _selectedProvince, (v) {
              setState(() {
                _selectedProvince = v;
                _selectedCity = null;
              });
            }),
            buildLabeledDropdown('Select City', _selectedProvince == null ? [] : cities[_selectedProvince]!, _selectedCity, (v) => setState(() => _selectedCity = v)),
            buildLabeledField('Street Address *', _addressController, 'Enter street address'),
            buildLabeledField('Postal Code *', _postalController, 'Enter postal code', keyboard: TextInputType.number),
            const SizedBox(height: 60),
          ],
        ),
      );

  // PAYMENT FORM — SAME PERFECT SPACING
  Widget _buildPaymentForm() => Form(
        key: _paymentFormKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 20),

            // Credit Card Only
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/mastercard.png', width: 60, height: 40),
                  const SizedBox(width: 16),
                  const Text('Credit Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  const Icon(Icons.check_circle, color: Colors.black, size: 32),
                ],
              ),
            ),
            const SizedBox(height: 40),

            buildLabeledField('Card Holder Name', _cardHolderController, 'Enter card holder name'),
            buildLabeledField('Card Number', _cardNumberController, '4111 1111 1111 1111', keyboard: TextInputType.number),
            Row(
              children: [
                Expanded(child: buildLabeledField('Expiry Date', _expiryController, 'MM/YY')),
                const SizedBox(width: 16),
                Expanded(child: buildLabeledField('CVV', _cvvController, '123', keyboard: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      );

  // PERFECT FIELD WITH SPACING
  Widget buildLabeledField(String label, TextEditingController controller, String hint, {String? prefix, TextInputType? keyboard}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            prefixText: prefix,
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  // PERFECT DROPDOWN WITH SPACING
    Widget buildLabeledDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28), // ← THIS FORCES THE GAP 100%
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
            validator: (v) => v == null ? 'Required' : null,
          ),
        ],
      ),
    );
  }
}