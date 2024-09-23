import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solidcheck/applicantsmodels.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all applicants from the 'applicants' collection
  Future<List<ApplicantsModels>> fetchApplicants() async {
    try {
      // Fetch the documents from 'applicants' collection
      QuerySnapshot snapshot = await _db.collection('applicants').get();

      // Map the documents to the ApplicantsModels
      List<ApplicantsModels> applicants = snapshot.docs.map((doc) {
        return ApplicantsModels.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return applicants;
    } catch (e) {
      print('Error fetching applicants: $e');
      return [];
    }
  }
}
