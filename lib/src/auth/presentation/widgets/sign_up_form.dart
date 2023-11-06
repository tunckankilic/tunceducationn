import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tunceducationn/core/common/widgets/changeable_field.dart';

class SignUpForm extends StatefulWidget {
  // SignUpForm sınıfı, kayıt formunu temsil eder.

  const SignUpForm({
    required this.emailController, // E-posta denetleyici
    required this.passwordController, // Şifre denetleyici
    required this.confirmPasswordController, // Şifre onayı denetleyici
    required this.formKey, // Form anahtar
    required this.fullNameController, // Ad ve soyad denetleyici
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController fullNameController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Kayıt formunun durum sınıfı

  bool obscurePassword = true; // Şifre gizleme durumu
  bool obscureConfirmPassword = true; // Şifre onayını gizleme durumu

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey, // Form anahtarını kullanarak Form'u tanımla
      child: Column(
        children: [
          ChangeableField(
            controller: widget.fullNameController, // Ad ve soyad denetleyicisi
            hintText: 'Full Name', // İpucu metni
            keyboardType: TextInputType.name, // Klavye türü
          ),
          const SizedBox(height: 25), // Boşluk ekleyin
          ChangeableField(
            controller: widget.emailController, // E-posta denetleyicisi
            hintText: 'Email address', // İpucu metni
            keyboardType: TextInputType.emailAddress, // Klavye türü
          ),
          const SizedBox(height: 25), // Boşluk ekleyin
          ChangeableField(
            controller: widget.passwordController, // Şifre denetleyicisi
            hintText: 'Password', // İpucu metni
            obscureText: obscurePassword, // Şifreyi gizleme özelliği
            keyboardType: TextInputType.visiblePassword, // Klavye türü
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword =
                      !obscurePassword; // Şifre gizleme durumunu tersine çevir
                });
              },
              icon: Icon(
                obscurePassword
                    ? IconlyLight.show
                    : IconlyLight.hide, // Göster veya gizle simgesi
                color: Colors.grey, // Simgenin rengi
              ),
            ),
          ),
          const SizedBox(height: 25), // Boşluk ekleyin
          ChangeableField(
            controller:
                widget.confirmPasswordController, // Şifre onayı denetleyicisi
            hintText: 'Confirm Password', // İpucu metni
            obscureText:
                obscureConfirmPassword, // Şifre onayını gizleme özelliği
            keyboardType: TextInputType.visiblePassword, // Klavye türü
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword =
                      !obscureConfirmPassword; // Şifre onayını gizleme durumunu tersine çevir
                });
              },
              icon: Icon(
                obscureConfirmPassword
                    ? IconlyLight.show
                    : IconlyLight.hide, // Göster veya gizle simgesi
                color: Colors.grey, // Simgenin rengi
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Passwords do not match'; // Şifreler uyuşmuyorsa hata mesajı
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
