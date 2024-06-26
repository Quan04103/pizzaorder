import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({super.key});

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameProfileController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  String getInitialFromLastWord(String name) {
    if (name.trim().isEmpty) {
      return '';
    }
    List<String> words = name.split(' ');
    if (words.isNotEmpty) {
      return words.last[0].toUpperCase();
    }
    return '';
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/getUserInfo'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _usernameController.text = data['username'];
        _nameProfileController.text = data['nameProfile'];
        _numberController.text = data['number'];
        _addressController.text = data['address'];
        _emailController.text = data['email'];
      });
    } else {
      print('Failed to load user data');
    }
  }

  Future<void> _editUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    setState(() {
      _isLoading = true;
    });

    // Tạo một đối tượng Map để chứa các trường dữ liệu cần gửi
    Map<String, dynamic> userData = {};

    if (_nameProfileController.text.isNotEmpty) {
      userData['nameProfile'] = _nameProfileController.text;
    }
    if (_numberController.text.isNotEmpty) {
      userData['number'] = _numberController.text;
    }
    if (_addressController.text.isNotEmpty) {
      userData['address'] = _addressController.text;
    }
    if (_emailController.text.isNotEmpty) {
      userData['email'] = _emailController.text;
    }

    final response = await http.put(
      Uri.parse('http://10.0.2.2:5000/editUser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(userData), // Gửi chỉ các trường được chỉ định
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        print('User updated successfully: $data');
        // Cập nhật lại UI hoặc thông báo thành công
      } catch (e) {
        print('Error parsing response JSON: $e');
        // Xử lý lỗi phân tích cú pháp JSON
      }
    } else {
      print('Failed to update user: ${response.body}');
      print('Status code: ${response.statusCode}');
      // Xử lý lỗi từ server
    }
  }

  void _onBackPressed(String token) {
    final router = GoRouter.of(context);
    router.go('/account', extra: token);
  }

  @override
  Widget build(BuildContext context) {
    String initial = _nameProfileController.text.isNotEmpty
        ? getInitialFromLastWord(_nameProfileController.text)
        : '';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: initial.isEmpty ? 0 : 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            // Handle back button press
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('token');

            _onBackPressed(token ?? '');
          },
        ),
        title: const Text(
          'Cập Nhật Thông Tin',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: const Color.fromARGB(255, 235, 224, 150),
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? Text(
                              initial,
                              style: TextStyle(
                                color: Colors.lime[800],
                                fontSize: 42.0,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameProfileController,
                decoration: const InputDecoration(labelText: 'Tên hiển thị'),
              ),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _editUser,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                  minimumSize:
                      const Size(double.infinity, 50), // <-- match parent
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
