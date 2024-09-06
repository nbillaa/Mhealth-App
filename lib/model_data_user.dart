import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel with ChangeNotifier {
  String _name = '';
  String _gender = '';
  int _age = 0;

  String get name => _name;
  String get gender => _gender;
  int get age => _age;

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setAge(int age) {
    _age = age;
    notifyListeners();
  }

  // Simpan data ke Firebase
  Future<void> saveUserData(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': _name,
        'gender': _gender,
        'age': _age,
      }, SetOptions(merge: true)); // Merge jika dokumen sudah ada
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Ambil data dari Firebase
  Future<void> loadUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // Casting dengan aman
        if (data != null) {
          _name = data['name'] as String? ?? '';
          _gender = data['gender'] as String? ?? '';
          _age = (data['age'] as num?)?.toInt() ?? 0; // Casting ke int jika perlu
          print('User Data Loaded: name=$_name, gender=$_gender, age=$_age');
          notifyListeners();
        } else {
          print('No data found for userId: $userId');
        }
      } else {
        print('No user data found for userId: $userId');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // Load user data setelah login
  Future<void> loadUserDataAfterLogin(String userId) async {
    await loadUserData(userId);
  }

  // Reset data ke default values
  void resetData() {
    _name = '';
    _gender = '';
    _age = 0;
    notifyListeners();
  }
}
