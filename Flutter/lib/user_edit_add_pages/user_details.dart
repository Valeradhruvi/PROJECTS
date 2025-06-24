import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_application/api/api_service.dart';
import 'package:matrimonial_application/api/user_model.dart';

class UserDetails extends StatefulWidget {
  final String index;

  const UserDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late Future<UserData> _userData;

  @override
  void initState() {
    super.initState();
    _userData = ApiService().getUserById(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(195, 126, 84, 0.8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/img_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          SingleChildScrollView(
            child: FutureBuilder<UserData>(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('No user data available', style: const TextStyle(color: Colors.white)));
                }

                final userData = snapshot.data!;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(195, 126, 84, 0.8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Icon(Icons.person_outline_outlined, size: 50, color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                userData.name,
                                style: GoogleFonts.habibi(
                                  textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildSectionTitle('About'),
                            _buildInfoCard('Gender', userData.gender),
                            _buildInfoCard('DOB', userData.dob),
                            _buildInfoCard('Hobby', userData.hobby),
                            _buildInfoCard('Age', userData.age.toString()),
                            const SizedBox(height: 20),
                            _buildSectionTitle('Religious Background'),
                            _buildInfoCard('Country', userData.country),
                            _buildInfoCard('State', userData.state),
                            _buildInfoCard('City', userData.city),
                            _buildInfoCard('Address', userData.address),
                            const SizedBox(height: 20),
                            _buildSectionTitle('Professional Details'),
                            _buildInfoCard('Higher Education', userData.hEducation),
                            _buildInfoCard('Occupation', userData.occupaation),
                            const SizedBox(height: 20),
                            _buildSectionTitle('Contact Details'),
                            _buildInfoCard('Number', userData.number),
                            _buildInfoCard('Email', userData.email),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(195, 120, 79, 0.8),
      persistentFooterButtons: const [
        Text('MeetME', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.habibi(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black))),
        const Divider(height: 5, thickness: 1, color: Color.fromRGBO(195, 126, 84, 0.5)),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label: ', style: GoogleFonts.habibi(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
            const SizedBox(width: 10),
            Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
          ],
        ),
      ),
    );
  }
}