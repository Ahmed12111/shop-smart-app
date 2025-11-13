import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:gap/gap.dart';

class CheckoutTheme {
  final Color primary;
  final Color cardBg;
  final Color error;
  final Color success;
  final Color border;
  final Color text;
  final Color textSecondary;
  final Color textAccent;
  final Color containerBg;
  final Color surface;

  const CheckoutTheme({
    required this.primary,
    required this.cardBg,
    required this.error,
    required this.success,
    required this.border,
    required this.text,
    required this.textSecondary,
    required this.textAccent,
    required this.containerBg,
    required this.surface,
  });

  factory CheckoutTheme.light() => CheckoutTheme(
    primary: Colors.black,
    cardBg: const Color(0xFF1A1F71),
    error: Colors.red[700]!,
    success: Colors.green[700]!,
    border: Colors.grey[300]!,
    text: const Color(0xFF1A237E),
    textSecondary: Colors.blue[700]!,
    textAccent: const Color(0xFF1565C0),
    containerBg: Colors.white,
    surface: const Color(0xFFF8F9FA),
  );

  factory CheckoutTheme.dark() => CheckoutTheme(
    primary: Colors.white,
    cardBg: Colors.grey[800]!,
    error: Colors.red[300]!,
    success: Colors.green[300]!,
    border: Colors.grey[700]!,
    text: const Color(0xFFBBDEFB),
    textSecondary: const Color(0xFF90CAF9),
    textAccent: const Color(0xFF64B5F6),
    containerBg: Colors.grey[800]!,
    surface: Colors.grey[900]!,
  );

  static CheckoutTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? CheckoutTheme.dark()
      : CheckoutTheme.light();
}

class CheckoutCard extends StatefulWidget {
  final double totalPrice;
  final Function(double) onPaymentSuccess;
  final CheckoutTheme? customTheme;

  const CheckoutCard({
    super.key,
    required this.totalPrice,
    required this.onPaymentSuccess,
    this.customTheme,
  });

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _saveCard = false;
  bool _termsAccepted = false;
  bool _isProcessing = false;
  String? _errorMessage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = widget.customTheme ?? CheckoutTheme.of(context);

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.surface,
        foregroundColor: theme.text,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalPrice(theme),
                  const Gap(24),
                  if (_errorMessage != null) ...[
                    _buildErrorBanner(theme),
                    const Gap(16),
                  ],
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName.toUpperCase(),
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    onCreditCardWidgetChange: (v) {},
                    cardBgColor: theme.cardBg,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(24),
                  CreditCardForm(
                    formKey: _formKey,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    onCreditCardModelChange: _onCardModelChange,
                    isCardHolderNameUpperCase: true,
                    inputConfiguration: InputConfiguration(
                      cardNumberDecoration: _inputDecoration(
                        'Card Number',
                        '1234 5678 9012 3456',
                        Icons.credit_card,
                        theme,
                      ),
                      expiryDateDecoration: _inputDecoration(
                        'Expiry Date',
                        'MM/YY',
                        Icons.calendar_today,
                        theme,
                      ),
                      cvvCodeDecoration: _inputDecoration(
                        'CVV',
                        '123',
                        Icons.lock,
                        theme,
                      ),
                      cardHolderDecoration: _inputDecoration(
                        'Cardholder Name',
                        'JOHN DOE',
                        Icons.person,
                        theme,
                      ),
                    ),
                  ),
                  const Gap(24),
                  _buildToggle(
                    value: _saveCard,
                    onChanged: (v) => setState(() => _saveCard = v!),
                    title: 'Save card for faster checkout',
                    subtitle: 'Secured with tokenization',
                    theme: theme,
                  ),
                  const Gap(16),
                  _buildToggle(
                    value: _termsAccepted,
                    onChanged: (v) => setState(() => _termsAccepted = v!),
                    title: 'I agree to the Terms & Conditions',
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(theme),
        ],
      ),
    );
  }

  Widget _buildTotalPrice(CheckoutTheme theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.containerBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.border),
      ),
      child: Column(
        children: [
          Text(
            'TOTAL AMOUNT',
            style: TextStyle(
              fontSize: 14,
              color: theme.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const Gap(8),
          Text(
            '\$${widget.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: theme.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(CheckoutTheme theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: theme.error),
          const Gap(12),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(
                color: theme.error,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: theme.error, size: 20),
            onPressed: () => setState(() => _errorMessage = null),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    String hint,
    IconData icon,
    CheckoutTheme theme,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: theme.textSecondary, size: 20),
      filled: true,
      fillColor: theme.containerBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.primary, width: 2),
      ),
      labelStyle: TextStyle(color: theme.textSecondary),
      hintStyle: TextStyle(color: theme.textSecondary.withOpacity(0.7)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildToggle({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String title,
    String? subtitle,
    required CheckoutTheme theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.containerBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: theme.primary,
            checkColor: theme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.text,
                  ),
                ),
                if (subtitle != null) ...[
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: theme.textSecondary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CheckoutTheme theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.text.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield, size: 16, color: theme.textSecondary),
                const Gap(8),
                Text(
                  'Your payment info is secure & encrypted',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(12),
            InkWell(
              onTap: _isProcessing ? null : _handlePlaceOrder,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _isProcessing
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: theme.surface,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'PLACE ORDER',
                          style: TextStyle(
                            color: theme.surface,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCardModelChange(CreditCardModel data) {
    setState(() {
      cardNumber = data.cardNumber;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      expiryDate = data.expiryDate;
      isCvvFocused = data.isCvvFocused;
    });
  }

  Future<void> _handlePlaceOrder() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      setState(() => _errorMessage = 'Please check your card details');
      return;
    }

    if (!_termsAccepted) {
      setState(() => _errorMessage = 'Please accept the terms');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isProcessing = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      widget.onPaymentSuccess(widget.totalPrice);
    } catch (e) {
      setState(() {
        _errorMessage = 'Payment failed: ${e.toString()}';
        _isProcessing = false;
      });
    }
  }
}
