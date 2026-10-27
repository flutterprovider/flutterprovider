import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/logger_utils.dart';

class FirestoreService {
  FirestoreService._();
  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─── Create / Set ────────────────────────────────────────────────────────────

  Future<DocumentReference> add(
      String collection, Map<String, dynamic> data) async {
    try {
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      return await _db.collection(collection).add(data);
    } catch (e) {
      AppLogger.error('Firestore add error: $e');
      rethrow;
    }
  }

  Future<void> set(
    String collection,
    String docId,
    Map<String, dynamic> data, {
    bool merge = true,
  }) async {
    try {
      data['updatedAt'] = FieldValue.serverTimestamp();
      await _db.collection(collection).doc(docId).set(data, SetOptions(merge: merge));
    } catch (e) {
      AppLogger.error('Firestore set error: $e');
      rethrow;
    }
  }

  // ─── Read ─────────────────────────────────────────────────────────────────────

  Future<DocumentSnapshot> getById(String collection, String docId) async {
    try {
      return await _db.collection(collection).doc(docId).get();
    } catch (e) {
      AppLogger.error('Firestore getById error: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot> getAll(
    String collection, {
    String? orderBy,
    bool descending = false,
    int? limit,
    Map<String, dynamic>? where,
  }) async {
    try {
      Query query = _db.collection(collection);
      if (where != null) {
        where.forEach((key, value) {
          query = query.where(key, isEqualTo: value);
        });
      }
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }
      if (limit != null) query = query.limit(limit);
      return await query.get();
    } catch (e) {
      AppLogger.error('Firestore getAll error: $e');
      rethrow;
    }
  }

  Stream<DocumentSnapshot> docStream(String collection, String docId) {
    return _db.collection(collection).doc(docId).snapshots();
  }

  Stream<QuerySnapshot> collectionStream(
    String collection, {
    String? orderBy,
    bool descending = false,
    Map<String, dynamic>? where,
  }) {
    Query query = _db.collection(collection);
    if (where != null) {
      where.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
    }
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    return query.snapshots();
  }

  // ─── Update ────────────────────────────────────────────────────────────────

  Future<void> update(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = FieldValue.serverTimestamp();
      await _db.collection(collection).doc(docId).update(data);
    } catch (e) {
      AppLogger.error('Firestore update error: $e');
      rethrow;
    }
  }

  // ─── Delete ────────────────────────────────────────────────────────────────

  Future<void> delete(String collection, String docId) async {
    try {
      await _db.collection(collection).doc(docId).delete();
    } catch (e) {
      AppLogger.error('Firestore delete error: $e');
      rethrow;
    }
  }

  // ─── Batch ─────────────────────────────────────────────────────────────────

  WriteBatch get batch => _db.batch();
}
