import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';

class parentViewProfile extends StatefulWidget {
  const parentViewProfile({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<parentViewProfile> {
  bool _isEditingCell = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;
  bool _isPasswordVisible = false;

  final TextEditingController _cellController =
      TextEditingController(text: "+27 89 678 4567");
  final TextEditingController _emailController =
      TextEditingController(text: "aprilpoti124@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "12345password");

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _enableEditing(String field) {
    setState(() {
      if (field == 'cell') {
        _isEditingCell = true;
      } else if (field == 'email') {
        _isEditingEmail = true;
      } else if (field == 'password') {
        _isEditingPassword = true;
      }
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditingCell = false;
      _isEditingEmail = false;
      _isEditingPassword = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
              color: kTextColor,
            )),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: kTextColor, fontSize: kTitleFontSize),
        ),
        backgroundColor: const Color(0xFF0F2E34),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildCombinedProfileCard(),
              const SizedBox(height: 24),
              if (_isEditingCell || _isEditingEmail || _isEditingPassword)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    child: const Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F2E34),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Color(0xFF0F2E34)),
            ),
            SizedBox(height: 16),
            Text(
              "April Poti",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            SizedBox(height: 8),
            Text("Parent/Guardian", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedProfileCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Details section
            const Text(
              "Profile Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2E34),
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileRow("Name", "April"),
            _buildProfileRow("Surname", "Poti"),
            _buildProfileRow("Identity Number", "8809168965794"),
            _buildProfileRow("Staff No", "68965794"),
            _buildProfileRow("Emis No", "546789"),
            _buildEditableRow("Cell", _cellController, _isEditingCell,
                _enableEditing, "cell"),
            _buildEditableRow("Email", _emailController, _isEditingEmail,
                _enableEditing, "email"),
            _buildEditableRow("Password", _passwordController,
                _isEditingPassword, _enableEditing, "password",
                isPassword: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF0F2E34))),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller,
      bool isEditing, Function enableEditing, String field,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF0F2E34))),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: !isEditing,
                  obscureText: isPassword && !_isPasswordVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: isEditing ? Colors.white : Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    hintText: !isEditing
                        ? (isPassword ? '**********' : controller.text)
                        : null,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF0F2E34)),
                    ),
                  ),
                ),
              ),
              if (isPassword && isEditing)
                IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF0F2E34),
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              if (!isEditing)
                TextButton(
                  onPressed: () => enableEditing(field),
                  child: const Text("Edit",
                      style: TextStyle(color: Color(0xFF0F2E34))),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
