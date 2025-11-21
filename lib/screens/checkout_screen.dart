// lib/screens/checkout_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0; // 0 = shipping, 1 = payment, 2 = success
  bool _isPlacingOrder = false;
  String? _paidAmount; // store final total so it does not become 0 after cart.clear()

  // FORM KEYS
  final _shippingFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  // SHIPPING CONTROLLERS
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;

  // PAYMENT CONTROLLERS
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  // SIMPLE NIGERIA LOCATION DATA
  final List<String> provinces = [
    'Abuja FCT',
    'Lagos',
    'Rivers',
    'Oyo',
    'Kano',
    'Kaduna',
    'Anambra',
    'Enugu',
    'Imo',
    'Delta',
    'Ogun',
    'Ondo',
    'Osun',
    'Edo',
    'Akwa Ibom',
    'Cross River',
    'Bayelsa',
    'Plateau',
    'Katsina',
    'Sokoto',
  ];

  final Map<String, List<String>> cities = {
    'Abuja FCT': [
      'Garki',
      'Wuse',
      'Maitama',
      'Asokoro',
      'Kubwa',
      'Jabi',
      'Gwagwalada',
      'Lugbe',
      'Durumi',
      'Utako'
    ],
    'Lagos': [
      'Ikeja',
      'Lekki',
      'Victoria Island',
      'Yaba',
      'Surulere',
      'Ajah',
      'Ikoyi',
      'Magodo',
      'Ogba',
      'Agege',
      'Alimosho',
      'Apapa',
      'Ikorodu',
      'Badagry',
      'Epe'
    ],
    'Rivers': [
      'Port Harcourt',
      'Obio-Akpor',
      'Eleme',
      'Oyigbo',
      'Okrika',
      'Etche',
      'Ikwerre',
      'Emohua',
      'Khana'
    ],
    'Oyo': [
      'Ibadan',
      'Ogbomosho',
      'Iseyin',
      'Oyo Town',
      'Saki',
      'Igboho',
      'Kisi',
      'Eruwa',
      'Igangan'
    ],
    'Kano': [
      'Kano Municipal',
      'Fagge',
      'Dala',
      'Gwale',
      'Tarauni',
      'Nassarawa',
      'Kumbotso',
      'Ungogo',
      'Dawakin Tofa'
    ],
    'Kaduna': [
      'Kaduna North',
      'Kaduna South',
      'Zaria',
      'Sabon Gari',
      'Chikun',
      'Kajuru',
      'Giwa',
      'Birnin Gwari'
    ],
    'Anambra': [
      'Awka',
      'Onitsha',
      'Nnewi',
      'Ihiala',
      'Aguata',
      'Idemili North',
      'Idemili South',
      'Ogbaru',
      'Orumba North'
    ],
    'Enugu': [
      'Enugu North',
      'Enugu South',
      'Nsukka',
      'Udi',
      'Nkanu West',
      'Uzo Uwani',
      'Ezeagu',
      'Igbo Etiti'
    ],
    'Imo': [
      'Owerri Municipal',
      'Owerri West',
      'Owerri North',
      'Okigwe',
      'Orlu',
      'Ideato North',
      'Mbaitoli',
      'Ngor Okpala'
    ],
    'Delta': [
      'Asaba',
      'Warri',
      'Sapele',
      'Ughelli',
      'Agbor',
      'Oleh',
      'Ozoro',
      'Kwale',
      'Abraka'
    ],
    'Ogun': [
      'Abeokuta North',
      'Abeokuta South',
      'Ijebu Ode',
      'Sagamu',
      'Ifo',
      'Ota',
      'Ado-Odo/Ota',
      'Yewa South'
    ],
    'Ondo': [
      'Akure',
      'Ondo Town',
      'Owo',
      'Ikare-Akoko',
      'Okitipupa',
      'Ore',
      'Idanre',
      'Igbokoda'
    ],
    'Osun': [
      'Osogbo',
      'Ile-Ife',
      'Ilesa',
      'Ede',
      'Ikire',
      'Iwo',
      'Ejigbo',
      'Ila Orangun'
    ],
    'Edo': [
      'Benin City',
      'Ekpoma',
      'Auchi',
      'Uromi',
      'Okada',
      'Irrua',
      'Fugar',
      'Agenebode'
    ],
    'Akwa Ibom': [
      'Uyo',
      'Eket',
      'Ikot Ekpene',
      'Abak',
      'Oron',
      'Ikot Abasi',
      'Etinan',
      'Ukanafun'
    ],
    'Cross River': [
      'Calabar',
      'Ogoja',
      'Ikom',
      'Obudu',
      'Ugep',
      'Akamkpa',
      'Obubra',
      'Bakassi'
    ],
    'Bayelsa': [
      'Yenagoa',
      'Sagbama',
      'Ogbia',
      'Nembe',
      'Brass',
      'Ekeremor',
      'Kolokuma/Opokuma',
      'Southern Ijaw'
    ],
    'Plateau': [
      'Jos',
      'Bukuru',
      'Pankshin',
      'Shendam',
      'Barkin Ladi',
      'Mangu',
      'Bokkos',
      'Wase'
    ],
    'Katsina': [
      'Katsina',
      'Funtua',
      'Daura',
      'Malumfashi',
      'Dutsin-Ma',
      'Kankia',
      'Bakori',
      'Batagarawa'
    ],
    'Sokoto': [
      'Sokoto',
      'Tambuwal',
      'Illela',
      'Gwadabawa',
      'Yabo',
      'Binji',
      'Wurno',
      'Rabah'
    ],
  };

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _postalController.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // SUCCESS PAGE
    if (_currentStep == 2) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Payment received!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _paidAmount != null ? 'Total paid: $_paidAmount' : '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order has been saved.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ORDER SUMMARY
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _row('Subtotal', cart.subtotalFormatted),
                _row('Shipping', cart.shippingFormatted),
                const Divider(),
                _row('Total', cart.totalFormatted, bold: true),
              ],
            ),
          ),

          // STEP CONTENT
          Expanded(
            child: _currentStep == 0 ? _shippingForm() : _paymentForm(),
          ),

          // BOTTOM BUTTON
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: BlackConfirmButton(
              text: _currentStep == 0
                  ? 'Continue to Payment'
                  : (_isPlacingOrder
                  ? 'Placing order...'
                  : 'Pay ${cart.totalFormatted}'),
              onPressed: _isPlacingOrder
                  ? null
                  : () async {
                if (_currentStep == 0) {
                  // validate shipping form
                  if (_shippingFormKey.currentState?.validate() !=
                      true ||
                      _selectedProvince == null ||
                      _selectedCity == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please fill all required fields correctly',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  setState(() => _currentStep = 1);
                } else {
                  // validate payment form then place order
                  if (_paymentFormKey.currentState?.validate() !=
                      true) {
                    return;
                  }
                  await _placeOrder(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FIRESTORE ORDER SAVE
  // ---------------------------------------------------------------------------

  Future<void> _placeOrder(BuildContext context) async {
    final cart = context.read<CartProvider>();

    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isPlacingOrder = true;
    });

    try {
      final addressString =
          '${_addressController.text.trim()}, ${_selectedCity ?? ''}, ${_selectedProvince ?? ''}, ${_postalController.text.trim()}';

      // build items array
      final items = cart.items.map((item) {
        return {
          'bookId': item.book.id,
          'title': item.book.title,
          'imagePath': item.book.imagePath,
          'price': item.book.price,
          'quantity': item.quantity,
        };
      }).toList();

      // build "bookName" summary like in your screenshot
      final firstTitle = cart.items.first.book.title;
      String bookNameLabel;
      if (cart.items.length == 1) {
        bookNameLabel = firstTitle;
      } else {
        final others = cart.items.length - 1;
        bookNameLabel =
        '$firstTitle and $others other item${others > 1 ? 's' : ''}';
      }

      final totalFormatted = cart.totalFormatted;

      await FirebaseFirestore.instance.collection('orders').add({
        'address': addressString,
        'bookName': bookNameLabel,
        'date': FieldValue.serverTimestamp(),
        'items': items,
        'subtotal': cart.subtotal,
        'shipping': cart.shipping,
        'total': cart.total,
        'status': 'pending',
      });

      // store paid amount for success screen BEFORE clearing cart
      _paidAmount = totalFormatted;

      // clear cart
      cart.clear();

      if (!mounted) return;
      setState(() {
        _isPlacingOrder = false;
        _currentStep = 2; // success screen
      });
    } catch (e, stack) {
      debugPrint('Error placing order: $e');
      debugPrint(stack.toString());
      if (!mounted) return;
      setState(() {
        _isPlacingOrder = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to place order. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // UI HELPERS
  // ---------------------------------------------------------------------------

  Widget _row(
      String label,
      String value, {
        bool bold = false,
      }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: bold ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  // SHIPPING FORM
  Widget _shippingForm() => Form(
    key: _shippingFormKey,
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // FULL NAME
        _field(
          _nameController,
          'Full Name *',
          keyboard: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
              return 'Invalid name format';
            }
            return null;
          },
        ),

        // PHONE NUMBER
        _field(
          _phoneController,
          'Phone Number *',
          prefix: '+234 ',
          keyboard: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (value.length != 10) return 'Invalid number';
            return null;
          },
        ),

        // STATE / PROVINCE
        DropdownButtonFormField<String>(
          value: _selectedProvince,
          decoration: _dec('State / Province *'),
          items: provinces
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChanged: (v) {
            setState(() {
              _selectedProvince = v;
              _selectedCity = null;
            });
          },
          validator: (v) => v == null ? 'Required' : null,
        ),
        const SizedBox(height: 16),

        // CITY
        DropdownButtonFormField<String>(
          value: _selectedCity,
          decoration: _dec('City *'),
          items: _selectedProvince == null
              ? const []
              : (cities[_selectedProvince] ?? [])
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChanged: _selectedProvince == null
              ? null
              : (v) {
            setState(() {
              _selectedCity = v;
            });
          },
          validator: (v) => v == null ? 'Required' : null,
        ),
        const SizedBox(height: 16),

        // STREET ADDRESS
        _field(
          _addressController,
          'Street Address *',
        ),

        // POSTAL CODE
        _field(
          _postalController,
          'Postal Code *',
          keyboard: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (value.length != 6) return 'Invalid';
            return null;
          },
        ),
        const SizedBox(height: 40),
      ],
    ),
  );

  // PAYMENT FORM
  Widget _paymentForm() => Form(
    key: _paymentFormKey,
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),

        // CARDHOLDER NAME
        _field(
          _cardHolderController,
          'Cardholder Name *',
          keyboard: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Required';
            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
              return 'Invalid format';
            }
            return null;
          },
        ),

        // CARD NUMBER
        _field(
          _cardNumberController,
          'Card Number *',
          hint: '1234 5678 9012 3456',
          keyboard: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
            LengthLimitingTextInputFormatter(19),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            final digitsOnly = value.replaceAll(' ', '');
            if (digitsOnly.length < 13 ||
                digitsOnly.length > 19 ||
                !RegExp(r'^\d+$').hasMatch(digitsOnly)) {
              return 'Invalid';
            }
            return null;
          },
        ),

        Row(
          children: [
            // EXPIRY
            Expanded(
              child: _field(
                _expiryController,
                'MM/YY *',
                keyboard: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  LengthLimitingTextInputFormatter(5),
                  _ExpiryDateInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            // CVV
            Expanded(
              child: _field(
                _cvvController,
                'CVV *',
                keyboard: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (value.length < 3 || value.length > 4) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
      ],
    ),
  );

  // REUSABLE TEXT FIELD
  Widget _field(
      TextEditingController controller,
      String label, {
        String? hint,
        String? prefix,
        TextInputType? keyboard,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator,
      }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboard,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixText: prefix,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator ??
                  (value) {
                if (value == null || value.trim().isEmpty) return 'Required';
                return null;
              },
        ),
      );

  InputDecoration _dec(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.grey[50],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

// Auto-format MM/YY as user types.
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length >= 3) {
      text =
      '${text.substring(0, 2)}/${text.substring(2, text.length.clamp(2, 4))}';
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class BlackConfirmButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BlackConfirmButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
