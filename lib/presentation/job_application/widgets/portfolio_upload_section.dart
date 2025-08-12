import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PortfolioUploadSection extends StatefulWidget {
  final List<XFile> selectedImages;
  final Function(List<XFile>) onImagesChanged;

  const PortfolioUploadSection({
    Key? key,
    required this.selectedImages,
    required this.onImagesChanged,
  }) : super(key: key);

  @override
  State<PortfolioUploadSection> createState() => _PortfolioUploadSectionState();
}

class _PortfolioUploadSectionState extends State<PortfolioUploadSection> {
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<bool> _requestPermissions() async {
    if (kIsWeb) return true;

    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  Future<void> _pickFromCamera() async {
    if (!await _requestPermissions()) {
      _showPermissionDialog();
      return;
    }

    setState(() => _isUploading = true);

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final updatedImages = List<XFile>.from(widget.selectedImages)
          ..add(image);
        widget.onImagesChanged(updatedImages);
      }
    } catch (e) {
      _showErrorDialog("Fehler beim Aufnehmen des Fotos");
    } finally {
      setState(() => _isUploading = false);
    }
  }

  Future<void> _pickFromGallery() async {
    if (!kIsWeb && !await _requestPermissions()) {
      _showPermissionDialog();
      return;
    }

    setState(() => _isUploading = true);

    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        final updatedImages = List<XFile>.from(widget.selectedImages)
          ..addAll(images);
        if (updatedImages.length > 5) {
          updatedImages.removeRange(5, updatedImages.length);
          _showErrorDialog("Maximal 5 Bilder erlaubt");
        }
        widget.onImagesChanged(updatedImages);
      }
    } catch (e) {
      _showErrorDialog("Fehler beim Auswählen der Bilder");
    } finally {
      setState(() => _isUploading = false);
    }
  }

  void _removeImage(int index) {
    final updatedImages = List<XFile>.from(widget.selectedImages)
      ..removeAt(index);
    widget.onImagesChanged(updatedImages);
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Berechtigung erforderlich"),
        content: const Text(
            "Bitte erlauben Sie den Zugriff auf Kamera und Speicher, um Bilder hochzuladen."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Fehler"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'photo_library',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                "Portfolio Bilder",
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                "Optional",
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            "Zeigen Sie Ihre bisherigen Arbeiten (max. 5 Bilder)",
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 2.h),
          if (widget.selectedImages.isEmpty)
            Container(
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'add_photo_alternate',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.6),
                    size: 48,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Bilder hinzufügen",
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 25.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 1.h,
                  childAspectRatio: 1,
                ),
                itemCount: widget.selectedImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: kIsWeb
                              ? Image.network(
                                  widget.selectedImages[index].path,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppTheme
                                          .lightTheme.colorScheme.surface,
                                      child: const Center(
                                        child: Icon(Icons.error),
                                      ),
                                    );
                                  },
                                )
                              : Image.file(
                                  File(widget.selectedImages[index].path),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppTheme
                                          .lightTheme.colorScheme.surface,
                                      child: const Center(
                                        child: Icon(Icons.error),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      Positioned(
                        top: 1.w,
                        right: 1.w,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: AppTheme.errorLight,
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconWidget(
                              iconName: 'close',
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isUploading || widget.selectedImages.length >= 5
                      ? null
                      : _pickFromCamera,
                  icon: _isUploading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.lightTheme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : CustomIconWidget(
                          iconName: 'camera_alt',
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          size: 18,
                        ),
                  label: Text(
                    "Kamera",
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isUploading || widget.selectedImages.length >= 5
                      ? null
                      : _pickFromGallery,
                  icon: _isUploading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        )
                      : CustomIconWidget(
                          iconName: 'photo_library',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 18,
                        ),
                  label: Text(
                    "Galerie",
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
            ],
          ),
          if (widget.selectedImages.length >= 5)
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                "Maximale Anzahl von 5 Bildern erreicht",
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.warningLight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
