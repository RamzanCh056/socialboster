

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadProgressProvider extends ChangeNotifier{
  double uploaded=0.0;
  double totalSize=0.0;
  double progressPercentage=0.0;
  bool uploading=false;

  updateProgress(double upload,double total,double progress){
    uploaded=upload;
    totalSize=total;
    progressPercentage=progress;
    notifyListeners();
  }

  setUploading(bool uploadingFile){
    uploading=uploadingFile;
    notifyListeners();
  }


}