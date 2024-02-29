



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/providers/upload_progress_provider.dart';

class StorageServices{

  Future<String?> uploadFile(File file, String storagePath,BuildContext context) async {
    try {
      UploadTask task = FirebaseStorage.instance.ref(storagePath).putFile(file);

      // Listen for state changes, errors, and completion of the upload.
      Provider.of<UploadProgressProvider>(context,listen:false).setUploading(true);
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes);
        Provider.of<UploadProgressProvider>(context,listen:false).updateProgress(
            snapshot.bytesTransferred.toDouble()/(1024*1024), snapshot.totalBytes.toDouble()/(1024*1024), progress);
      });

      // Await completion of the upload
      await task;


      Provider.of<UploadProgressProvider>(context,listen:false).updateProgress(
          0.0, 0.0, 0.0);
      Provider.of<UploadProgressProvider>(context,listen:false).setUploading(false);
      // Get the download URL of the uploaded file
      String downloadURL = await task.snapshot.ref.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}