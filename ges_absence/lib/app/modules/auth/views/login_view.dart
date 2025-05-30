import 'package:flutter/material.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C1E17), // fond marron foncé
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo ISM
                Image.asset(
                  'assets/images/ism_logo.png',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 16),
                Text(
                  'ISM',
                  style: TextStyle(
                    fontSize: 28,
                    color: const Color(0xFFFFA726),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // Login Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _loginController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration(
                    hint: "Entrer votre identifiant",
                    icon: Icons.person,
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Identifiant requis" : null,
                ),
                const SizedBox(height: 24),

                // Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Mot de passe", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Obx(() => TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        hint: "Entrer votre mot de passe",
                        icon: Icons.lock,
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            _obscurePassword.value = !_obscurePassword.value;
                          },
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Mot de passe requis" : null,
                    )),
                const SizedBox(height: 32),

                // Submit Button
                Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.orange)
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.login(
                                _loginController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA726),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Connexion",
                              style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
  }
}