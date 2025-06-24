// UserRegisterPage.dart

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_application/api/api_service.dart';
import 'package:matrimonial_application/api/user_model.dart';
import 'package:matrimonial_application/class_user/user.dart';
import 'package:matrimonial_application/database/database.dart';
import 'package:matrimonial_application/user_edit_add_pages/user_list.dart';

class UserRegisterPage extends StatefulWidget {
  ApiService apiService = ApiService();

  final UserData? userDetailss;
  final bool isEdit;
  final String? index;

  UserRegisterPage({Key? key, this.userDetailss, this.isEdit = false, this.index})
      : super(key: key);

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {

  //region DECLARATIONS


  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  // Form Key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Dropdown for Lists
  List<String>? Education = ["M.Tech", 'M.D', 'M.Ed', 'M.A'];
  List<String>? Occupation = [
    'SoftWare Engineer',
    'Mechanical Engineer',
    'Civil Engineer',
    'EC Engineer',
    'Electrical Engineer',
    'AI Trainer',
    'Spe. Doctor',
    'Professor',
    'Social Worker'
  ];
  List<String> items = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];

  List<String> coutries = [
    "Belgium",
    "Bhutan",
    "Denmark",
    "Germany",
    "India",
    "Indonesia",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Syria"
  ];
  List<String> city = [
    'Mumbai',
    'Jamnagar',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Rajkot',
    'Chennai',
    'Kolkata',
    'Ahmedabad',
    'Jaipur',
    'Surat',
    'Pune'
  ];

  String selectedShaher = "Jamnagar";
  String selectedCountry = "India";
  String selectedEducation = "M.Tech";
  String selectedOccupation = "SoftWare Engineer";
  String selectedCity = 'Gujarat';

  bool isHide = true;

  // Hobbies
  bool isDance = false;
  bool isSleeping = false;
  bool isSinging = false;
  bool isCooking = false;

  // Gender
  int _radioSelected = 1;
  String? _radioVal = 'male';

  // Date of Birth
  String dob = 'Select DOB';
  DateTime? selectedDOB;

  DateTime initialDate =
  DateTime(DateTime.now().year - 18, DateTime.january, DateTime.january);
  DateTime firstDate =
  DateTime(DateTime.now().year - 80, DateTime.january, DateTime.january);

  int? age;


  // endregion

  void resetForm() {
    nameController.clear();
    addressController.clear();
    emailController.clear();
    numberController.clear();
    passwordController.clear();
    confirmPassController.clear();
    setState(() {
      selectedCity = "";
      selectedCountry = "";
      selectedShaher = "";
      selectedEducation = "";
      selectedOccupation = "";
      isDance = false;
      isSleeping = false;
      isSinging = false;
      isCooking = false;
      _radioSelected = 1;
      _radioVal = 'male';
      dob = 'Select DOB';
      selectedDOB = null;
    });
  }

  User userlist = User();

  @override
  void initState() {
    super.initState();

    if (widget.userDetailss != null) {
      nameController.text = widget.userDetailss!.name ?? '';
      addressController.text = widget.userDetailss!.address ?? '';
      emailController.text = widget.userDetailss!.email ?? '';
      numberController.text = widget.userDetailss!.number ?? '';
      _radioVal = widget.userDetailss!.gender ?? '';
      dob = widget.userDetailss!.dob ?? '';
      passwordController.text = widget.userDetailss!.password ?? '';
      confirmPassController.text =
          widget.userDetailss!.confirmPassword ?? '';
      if (widget.userDetailss!.hobby != null) {
        isDance = widget.userDetailss!.hobby!.contains('Dance');
        isSinging = widget.userDetailss!.hobby!.contains('Singing');
        isSleeping = widget.userDetailss!.hobby!.contains('Sleeping');
      }
      if (widget.userDetailss!.dob != null &&
          widget.userDetailss!.dob.toString().isNotEmpty) {
        selectedDOB = DateTime.tryParse(widget.userDetailss!.dob ?? '');
      }
      print(" **************  ${widget.userDetailss!.city}");
      selectedCity = widget.userDetailss!.state;
      // selectedOccupation = widget.userDetailss!.occupaation;
      selectedEducation = widget.userDetailss!.hEducation;
      selectedShaher = widget.userDetailss!.city;
      selectedCountry = widget.userDetailss!.country;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(195, 120, 79, 0.8),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(195, 126, 84, 0.8),
        title: Text(widget.isEdit ? 'Edit User' : 'Add User',
            style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/img_2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          //region BACKDROP
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          //endregion

          Form(
            key: _formKey,
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              child: Container(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter valid name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12,
                          ),
                          labelText: 'Enter your name',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.person), // Add prefix icon
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        obsecureText: false,
                        length: 150,
                        label: 'Address',
                        controller: addressController,
                        validatorMessage: 'Enter a valid address',
                        icon: Icons.home,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        obsecureText: false,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email',
                        controller: emailController,
                        validatorMessage: 'Enter a valid email',
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                        obsecureText: false,
                        length: 10,
                        label: 'Contact No.',
                        controller: numberController,
                        validatorMessage: 'Enter a valid contact number',
                        keyboardType: TextInputType.phone,
                        icon: Icons.phone,
                      ),
                      const SizedBox(height: 16),
                      //region Higher Education
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedEducation,
                              decoration: InputDecoration(
                                label: const Text('Higher Education'),
                                labelStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                prefixIcon: Icon(Icons.school),
                              ),
                              isExpanded: true,
                              items: Education!.map((education) {
                                return DropdownMenuItem(
                                    value: education, child: Text(education));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedEducation = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your education field';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      //endregion
                      const SizedBox(height: 16),
                      //region Occupation
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedOccupation,
                              decoration:  InputDecoration(
                                label: Text('Occupation'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                prefixIcon: Icon(Icons.work),
                              ),
                              items: Occupation!.map((occupation) {
                                return DropdownMenuItem(
                                    value: occupation, child: Text(occupation));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedOccupation = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an Occupation';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      //endregion
                      const SizedBox(height: 16),
                      //region country
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCountry,
                              decoration:  InputDecoration(
                                label: Text('Country'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                prefixIcon: Icon(Icons.flag),
                              ),
                              items: coutries.map((country) {
                                return DropdownMenuItem(
                                    value: country, child: Text(country));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCountry = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a Country';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      //endregion
                      const SizedBox(height: 16),
                      //region State
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCity,
                              decoration:  InputDecoration(
                                label: Text('State'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String state) {
                                return DropdownMenuItem(
                                  value: state,
                                  child: Text(state),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCity = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a State';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      //endregion
                      const SizedBox(height: 16),

                      //region city
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedShaher,
                              decoration:  InputDecoration(
                                label: Text('City'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                prefixIcon: Icon(Icons.location_city),
                              ),
                              items: city.map((city) {
                                return DropdownMenuItem(
                                    value: city, child: Text(city));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedShaher = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a City';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      //endregion
                      const SizedBox(height: 16),
                      buildGenderRadioButtons(),
                      const SizedBox(height: 16),
                      buildDOBPicker(),
                      const SizedBox(height: 16),
                      buildHobbies(),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: isHide,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter valid Password';
                          } else if (value.length < 8) {
                            return "Password must be atleast 8 characters long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHide = !isHide;
                                  });
                                },
                                icon: Icon(isHide
                                    ? Icons.visibility
                                    : Icons.visibility_off)
                            ),
                            labelText: 'Enter password',
                            labelStyle: const TextStyle(color: Colors.black54),
                            prefixIcon: Icon(Icons.lock)
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: isHide,
                        controller: confirmPassController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter valid password';
                          } else if (value.length < 8) {
                            return "Password must be of exact 8 characters long";
                          } else if (value != passwordController.text) {
                            return 'password doesn\'t match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            labelText: 'Confirm password',
                            labelStyle: const TextStyle(color: Colors.black54),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHide = !isHide;
                                  });
                                },
                                icon: Icon(isHide
                                    ? Icons.visibility
                                    : Icons.visibility_off)
                            ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        const Text(
          'MeetME',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }


  Widget buildTextField({
    List<TextInputFormatter>? inputFormatter,
    required bool obsecureText,
    String? initialValue,
    String? textCapitalizde,
    int? length,
    required String label,
    required TextEditingController controller,
    required String validatorMessage,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon, // Optional icon parameter
  }) {
    return TextFormField(
      inputFormatters: inputFormatter,
      obscureText: obsecureText,
      maxLength: length,
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        prefixIcon: icon != null ? Icon(icon) : null, // Add icon if provided
      ),
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }

        // Email validation
        if (label == 'Email') {
          var emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
          if (!emailRegex.hasMatch(value)) {
            return 'Enter a valid email address';
          }
        }

        // Contact number validation
        if (label == 'Contact No.') {
          var phoneRegex = RegExp(r'^[0-9]{10}$');
          if (!phoneRegex.hasMatch(value)) {
            return 'Enter a valid 10-digit phone number';
          }
        }
        return null;
      },
    );
  }

  Widget buildGenderRadioButtons() {
    return Row(
      children: [
        const Text('Gender:', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 20),
        Row(
          children: [
            const Text('Male'),
            Radio(
              value: 1,
              groupValue: _radioSelected,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                  _radioVal = 'male';
                });
              },
            ),
            const Text('Female'),
            Radio(
              value: 2,
              groupValue: _radioSelected,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                  _radioVal = 'female';
                });
              },
            ),
            const Text('Other'),
            Radio(
              value: 3,
              groupValue: _radioSelected,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                  _radioVal = 'Other';
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDOBPicker() {
    String getFormattedDate(String date) {
      DateTime dateTime = DateFormat('dd-MM-yyyy').parse(date);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    return Row(
      children: [
        const Text('DOB:', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 20),
        InkWell(
          child: Text(
            dob.isNotEmpty ? dob : "Select DOB",
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: initialDate,
            );

            if (selectedDate != null) {
              age = DateTime.now().year - selectedDate.year;
              if (age! < 18 || age! > 80) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "You must be at least 18 and at most 80 years old."),
                  ),
                );
              } else {
                selectedDOB = selectedDate;
                dob = getFormattedDate(
                    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
                setState(() {});
              }
            }
          },
        ),
      ],
    );
  }

  Widget buildHobbies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hobbies:', style: TextStyle(fontSize: 16)),
        CheckboxListTile(
          title: const Text('Dance'),
          value: isDance,
          onChanged: (value) {
            setState(() {
              isDance = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Sleeping'),
          value: isSleeping,
          onChanged: (value) {
            setState(() {
              isSleeping = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Singing'),
          value: isSinging,
          onChanged: (value) {
            setState(() {
              isSinging = value!;
            });
          },
        ),
      ],
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String name = nameController.text.trim();
              String address = addressController.text.trim();
              String email = emailController.text.trim();
              String number = numberController.text.trim();
              String age = (selectedDOB != null)
                  ? (DateTime.now().year - selectedDOB!.year).toString()
                  : ''; // Handle potential null `selectedDOB`
              String Heducation = selectedEducation ?? '';
              String occupation = selectedOccupation ?? '';
              String country = selectedCountry ?? '';
              String state = selectedCity ?? '';
              String city = selectedShaher ?? '';
              String gender = _radioVal ?? '';
              String dob = selectedDOB?.toString() ?? '';
              String hobbies = [
                if (isDance) 'Dance',
                if (isSleeping) 'Sleeping',
                if (isSinging) 'Singing',
              ].where((hobby) => hobby != null).toList().toString();
              String password = passwordController.text.trim();
              String confrimPassword = confirmPassController.text.trim();

              // UserRegisterPage.dart
              if (widget.isEdit) {
                widget.apiService.updateUser(UserData(
                    id: widget.userDetailss!.id, // Correct!
                    name: name,
                    address: address,
                    email: email,
                    number: number,
                    age: age,
                    hEducation: Heducation,
                    occupaation: occupation,
                    country: country,
                    state: state,
                    city: city,
                    gender: gender,
                    dob: dob,
                    hobby: hobbies,
                    password: password,
                    confirmPassword: confrimPassword));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User Edited Successfully")),
                );
                Navigator.of(context).pop();
              } else {
                widget.apiService.addUser(UserData(
                    id: '',  // Correct ID is null
                    name: name,
                    address: address,
                    email: email,
                    number: number,
                    age: age,
                    hEducation: Heducation,
                    occupaation: occupation,
                    country: country,
                    state: state,
                    city: city,
                    gender: gender,
                    dob: dob,
                    hobby: hobbies,
                    password: password,
                    confirmPassword: confrimPassword));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User Added Successfully")),
                );

                Navigator.of(context).pop();
              }
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
          child: Text(
            widget.isEdit ? 'EDIT' : 'ADD',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: resetForm,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
          child: const Text(
            'RESET',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

}