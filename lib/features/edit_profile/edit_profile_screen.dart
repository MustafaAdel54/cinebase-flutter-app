import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/shared/widgets/input_field.dart';
import 'package:imdb/shared/widgets/primary_button.dart';
import 'package:imdb/shared/widgets/secondary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _email = TextEditingController();
  final _phoneController = TextEditingController();

  String? selectedGender = 'Male';
  DateTime selectedDate = DateTime(1994, 5, 12); // Default date
  final TextEditingController _dateController = TextEditingController(
    text: "May 12, 1994",
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          _nameController.text = doc['fullName'] ?? '';
          _email.text = doc['email'] ?? '';
          _phoneController.text = doc['phoneNumber'] ?? '';
          selectedGender = doc['gender'] ?? 'Male';
          if (doc['birthDate'] != null) {
            selectedDate = DateTime.parse(doc['birthDate']);
            _dateController.text =
                "${_getMonthName(selectedDate.month)} ${selectedDate.day}, ${selectedDate.year}";
          }
        });
      }
    }
  }

  Future<void> _saveProfileChanges() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
              'fullName': _nameController.text.trim(),
              'phoneNumber': _phoneController.text.trim(),
              'gender': selectedGender, // تحديث النوع
              'birthDate': selectedDate.toIso8601String(),
            });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated Successfully!")),
        );
      } catch (e) {
        print("Error updating profile: $e");
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFFD740), // Your yellow theme color
              onPrimary: Colors.black,
              surface: Color(0xFF1A1A1A), // Dark background
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format the date for the text field
        _dateController.text =
            "${_getMonthName(picked.month)} ${picked.day}, ${picked.year}";
      });
    }
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/user.png',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.primary, // Yellow background
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'CHANGE PROFILE PHOTO',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                child: Text('Full NAME'),
              ),
              InputField(controller: _nameController, hintText: 'MustafaAdel'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                child: Text('Email Address'),
              ),
              InputField(controller: _email, hintText: 'example@gmail.com'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                child: Text('Phone Number'),
              ),
              InputField(
                controller: _phoneController,
                hintText: '+201063758561',
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                          child: Text('Gender'),
                        ),
                        DropdownButtonFormField<String>(
                          initialValue: selectedGender,
                          dropdownColor: const Color(
                            0xFF1A1A1A,
                          ), // Background of the popup
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(
                              0xFF1A1A1A,
                            ), // Matches your other fields
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                          ),
                          // Customizing the arrow icon to match your design
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          items: ["Male", "Female", "Other"].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text("BIRTH DATE"),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 48,
                          child: TextFormField(
                            controller: _dateController,
                            readOnly: true, // Prevents keyboard from appearing
                            onTap: () => _selectDate(
                              context,
                            ), // Opens the calendar on tap
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(
                                0xFF1A1A1A,
                              ), // Matches your dark theme
                              suffixIcon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SecondaryButton(
                label: 'Delete Account',
                labelColor: Colors.red,
                showIcon: true,
                icon: Icons.delete,
                iconColor: Colors.red,
                iconSize: 25.0,
                borderColor: Colors.red,
                onPressed: () {},
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: PrimaryButton(
          labelColor: Colors.black,
          label: 'Save Changes',
          onPressed: _saveProfileChanges,
        ),
      ),
    );
  }
}
