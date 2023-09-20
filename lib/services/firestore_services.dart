import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // HomeScreen
  Future<QuerySnapshot<Map<String, dynamic>>> getIconMenuData(
    String enCountryName,
    String localeName,
    String iconMenu,
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('home_screen')
              .doc('icon_menus')
              .collection(enCountryName)
              .doc(localeName)
              .collection(iconMenu)
              .startAfterDocument(lastDoc)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get icon menu data: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            })
          : await _firestore
              .collection('home_screen')
              .doc('icon_menus')
              .collection(enCountryName)
              .doc(localeName)
              .collection(iconMenu)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get icon menu data: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            });

  Future<void> setIconMenuData(
    String enCountryName,
    String localeName,
    String iconMenu,
    String atPlaceId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('icon_menus')
          .collection(enCountryName)
          .doc(localeName)
          .collection(iconMenu)
          .doc(atPlaceId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        debugPrint('Cannot set merge icon menu data: ${e.toString()}');
      });

  Future<void> deleteIconMenuData(
    String enCountryName,
    String localeName,
    String iconMenu,
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('icon_menus')
          .collection(enCountryName)
          .doc(localeName)
          .collection(iconMenu)
          .doc(atPlaceId)
          .delete()
          .catchError((e) {
        debugPrint('Cannot delete icon menu data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getPromotionData(
    String enCountryName,
    String localeName,
    String province,
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('home_screen')
              .doc('promotions')
              .collection(enCountryName)
              .doc(localeName)
              .collection(province)
              .startAfterDocument(lastDoc)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get promotion data: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            })
          : await _firestore
              .collection('home_screen')
              .doc('promotions')
              .collection(enCountryName)
              .doc(localeName)
              .collection(province)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get promotion data: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            });

  Future<void> setPromotionData(
    String enCountryName,
    String localeName,
    String province,
    String atPlaceId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('promotions')
          .collection(enCountryName)
          .doc(localeName)
          .collection(province)
          .doc(atPlaceId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        debugPrint('Cannot set merge promotion data: ${e.toString()}');
      });

  Future<void> deletePromotionData(
    String enCountryName,
    String localeName,
    String province,
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('promotions')
          .collection(enCountryName)
          .doc(localeName)
          .collection(province)
          .doc(atPlaceId)
          .delete()
          .catchError((e) {
        debugPrint('Cannot delete promotion data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getProvinceData(
    String enCountryName,
    String localeName,
    String province,
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('home_screen')
              .doc('provinces')
              .collection(enCountryName)
              .doc(localeName)
              .collection(province)
              .startAfterDocument(lastDoc)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get Province data: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            })
          : await _firestore
              .collection('home_screen')
              .doc('provinces')
              .collection(enCountryName)
              .doc(localeName)
              .collection(province)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get Province data: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            });

  Future<void> setProvinceData(
    String enCountryName,
    String localeName,
    String province,
    String atPlaceId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces')
          .collection(enCountryName)
          .doc(localeName)
          .collection(province)
          .doc(atPlaceId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        debugPrint('Cannot set merge Province data: ${e.toString()}');
      });

  Future<void> deleteProvinceData(
    String enCountryName,
    String localeName,
    String province,
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces')
          .collection(enCountryName)
          .doc(localeName)
          .collection(province)
          .doc(atPlaceId)
          .delete()
          .catchError((e) {
        debugPrint('Cannot delete Province data: ${e.toString()}');
      });

  Future<Map<String, dynamic>> getProvinceCounter(
    String enCountryName,
    String localeName,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces_total_places')
          .collection(enCountryName)
          .doc(localeName)
          .get()
          .then((snapshot) => snapshot.data()!)
          .catchError((e) {
        debugPrint('Cannot get Province counter: ${e.toString()}');
        return Future<Map<String, dynamic>>.value({});
      });

  Future<void> initializeProvinceCounter(
    String enCountryName,
    String localeName,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces_total_places')
          .collection(enCountryName)
          .doc(localeName)
          .set({
        "Phnom Penh": 0,
        "Siem Reap": 0,
        "Kampot": 0,
        "Sihanoukville": 0,
        "Mondulkiri": 0,
        "Koh Kong": 0,
        "Rattanakiri": 0,
        "Kep": 0,
        "Preah Vihear": 0,
        "Kratie": 0,
        "Battambang": 0,
        "Banteay Meanchey": 0,
        "Kampong Cham": 0,
        "Kandal": 0,
        "Pursat": 0,
        "Pailin": 0,
        "Kampong Chhnang": 0,
        "Kampong Speu": 0,
        "Kampong Thom": 0,
        "Prey Veng": 0,
        "Stung Treng": 0,
        "Svay Rieng": 0,
        "Takeo": 0,
        "Oddar Meanchey": 0,
        "Tbong Khmum": 0,
      }, SetOptions(merge: false)).catchError((e) {
        debugPrint('Cannot Initialize Province Counters: ${e.toString()}');
      });

  Future<void> increaseProvinceCounter(
    String enCountryName,
    String localeName,
    String atProvince,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces_total_places')
          .collection(enCountryName)
          .doc(localeName)
          .update({
        atProvince: int.parse(
                await getProvinceCounter(enCountryName, localeName)
                    .then((data) => data[atProvince].toString())) +
            1
      }).catchError((e) {
        debugPrint(
            'Cannot update value in provinces_total_places: ${e.toString()}');
      });

  Future<void> decreaseProvinceCounter(
    String enCountryName,
    String localeName,
    String atProvince,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces_total_places')
          .collection(enCountryName)
          .doc(localeName)
          .update({
        atProvince: int.parse(
                await getProvinceCounter(enCountryName, localeName)
                    .then((data) => data[atProvince].toString())) -
            1
      }).catchError((e) {
        debugPrint(
            'Cannot update value in provinces_total_places: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getTabBarData(
    String enCountryName,
    String localeName,
    String tab,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('tab_lists')
          .collection(enCountryName)
          .doc(localeName)
          .collection(tab)
          .orderBy('placeId', descending: true)
          .limit(5)
          .get()
          .catchError((e) {
        debugPrint('Cannot get TabList data: ${e.toString()}');
        return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setTabBarData(
    String enCountryName,
    String localeName,
    String tab,
    String atPlaceId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('tab_lists')
          .collection(enCountryName)
          .doc(localeName)
          .collection(tab)
          .doc(atPlaceId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        debugPrint('Cannot set merge TabList data: ${e.toString()}');
      });

  Future<void> deleteTabBarData(
    String enCountryName,
    String localeName,
    String tab,
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('tab_lists')
          .collection(enCountryName)
          .doc(localeName)
          .collection(tab)
          .doc(atPlaceId)
          .delete()
          .catchError((e) {
        debugPrint('Cannot delete TabList data: ${e.toString()}');
      });

  Future<Map<String, dynamic>> readPlaceSearchData(
    String enCountryName,
    String localeName,
  ) async {
    int segment = 0;
    bool shouldStop = false;
    Map<String, dynamic> data = {};
    do {
      data = {
        ...data,
        ...(await _firestore
            .collection('home_screen')
            .doc('searches')
            .collection(enCountryName)
            .doc(localeName)
            .collection('segments')
            .doc(segment.toString())
            .get()
            .catchError((e) {
          shouldStop = true;
          return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
        }).then((documentSnapshot) {
          if (documentSnapshot.exists) {
            return documentSnapshot.data()!;
          } else {
            shouldStop = true;
            return {};
          }
        }))
      };
      segment++;
    } while (!shouldStop);
    return data;
  }

  Future<void> setPlaceSearchData(
    String enCountryName,
    String localeName,
    String key,
    String placeId,
  ) async {
    Map<String, dynamic> searches =
        await readPlaceSearchData(enCountryName, localeName).catchError((e) {
      debugPrint('Cannot read search place data: ${e.toString()}');
      return Future<Map<String, dynamic>>.value({});
    });
    searches[key] = placeId;
    for (int segment = 0; segment <= searches.length ~/ 2000; segment++) {
      await _firestore
          .collection('home_screen')
          .doc('searches')
          .collection(enCountryName)
          .doc(localeName)
          .collection('segments')
          .doc(segment.toString())
          .set(Map.fromEntries(
              searches.entries.skip(segment * 2000).take((segment + 1) * 2000)))
          .catchError((e) {
        debugPrint('Cannot add search place data to firestore: $e');
      });
    }
  }

  Future<void> deletePlaceSearchData(
    String enCountryName,
    String localeName,
    String key,
  ) async {
    Map<String, dynamic> searches =
        await readPlaceSearchData(enCountryName, localeName).catchError((e) {
      debugPrint('Cannot read search place data: ${e.toString()}');
      return Future<Map<String, dynamic>>.value({});
    });
    searches.remove(key);
    for (int segment = 0; segment <= searches.length ~/ 2000; segment++) {
      await _firestore
          .collection('home_screen')
          .doc('searches')
          .collection(enCountryName)
          .doc(localeName)
          .collection('segments')
          .doc(segment.toString())
          .set(Map.fromEntries(
              searches.entries.skip(segment * 2000).take((segment + 1) * 2000)))
          .catchError((e) {
        debugPrint('Cannot delete search place data from firestore: $e');
      });
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getPlaceData(
    String enCountryName,
    String localeName,
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('icon_menus')
          .collection(enCountryName)
          .doc(localeName)
          .collection('modelIconMenus.last.label')
          .doc(atPlaceId)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists && documentSnapshot.data()!.isNotEmpty) {
          return documentSnapshot;
        }
      }).catchError((e) {
        debugPrint('Cannot get place data $atPlaceId: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<List<dynamic>> readPlaceRatings(
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('ratings')
          .collection('_')
          .doc(atPlaceId)
          .get()
          .then((documentSnapshot) => documentSnapshot.exists
              ? documentSnapshot.get('ratings')
              : Future<List>.value([]))
          .catchError((e) {
        debugPrint('Cannot read place rating: ${e.toString()}');
      });

  Future<double> getPlaceRatingRate(
    String atPlaceId,
  ) async =>
      await readPlaceRatings(atPlaceId).then((ratings) {
        int total = 0;
        for (Map<String, dynamic> rating in ratings) {
          total += int.parse(rating['rating'].toString());
        }
        return total == 0 ? 4 : total / ratings.length;
      });

  Future<void> setPlaceRating(
    String atPlaceId,
    String uid,
    Map<String, dynamic> data,
  ) async {
    List<dynamic> ratings = await readPlaceRatings(atPlaceId).catchError((e) {
      debugPrint('Cannot read ratings: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });

    for (Map<String, dynamic> rating in ratings) {
      if (rating['uid'].toString().contains(uid)) {
        ratings.remove(rating);
        break;
      }
    }
    ratings.add(data);

    await _firestore
        .collection('home_screen')
        .doc('ratings')
        .collection('_')
        .doc(atPlaceId)
        .set(
      {'ratings': ratings},
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add ratings to Place: ${e.toString()}');
    });
  }

  Future<void> removePlaceRating(
    String atPlaceId,
    String uid,
  ) async {
    List<dynamic> ratings = await readPlaceRatings(atPlaceId).catchError((e) {
      debugPrint('Cannot read ratings: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });

    for (Map<String, dynamic> rating in ratings) {
      if (rating['uid'].toString().contains(uid)) {
        ratings.remove(rating);
        break;
      }
    }

    await _firestore
        .collection('home_screen')
        .doc('ratings')
        .collection('_')
        .doc(atPlaceId)
        .set(
      {'ratings': ratings},
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot remove ratings from Place: ${e.toString()}');
    });
  }

  List<int> getPlaceRatingExpression(
    List<dynamic> ratings,
    String atUid,
  ) {
    List<int> expression = [];
    for (Map<String, dynamic> rating in ratings) {
      if (rating['uid'].toString().contains(atUid)) {
        try {
          expression.add(int.parse(rating['likes'].toString()));
          expression.add(int.parse(rating['dislikes'].toString()));
        } catch (e) {
          debugPrint('Cannot read integer likes and dislikes ${e.toString()}');
        }
        break;
      }
    }
    return expression;
  }

  Future<void> setPlaceRatingExpression(
    String atPlaceId,
    String uid,
    int likes,
    int dislikes,
  ) async {
    List<dynamic> ratings = await readPlaceRatings(atPlaceId).catchError((e) {
      debugPrint('Cannot read ratings: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });

    for (Map<String, dynamic> rating in ratings) {
      if (rating['uid'] == uid) {
        rating['likes'] = likes;
        rating['dislikes'] = dislikes;
        break;
      }
    }

    await _firestore
        .collection('home_screen')
        .doc('ratings')
        .collection('_')
        .doc(atPlaceId)
        .set(
      {'ratings': ratings},
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add ratings to Place: ${e.toString()}');
    });
  }

  Future<List<dynamic>> readPlaceGallery(
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('gallery')
          .collection(atPlaceId)
          .doc('_')
          .get()
          .then((documentSnapshot) =>
              documentSnapshot.exists ? documentSnapshot.get('imageUrls') : [])
          .catchError((e) {
        debugPrint('Cannot retrieve Gallery data: ${e.toString()}');
      });

  Future<void> setPlaceGalleryImages(
    String atPlaceId,
    List<String> imageUrls,
  ) async {
    List<String> gallery = await readPlaceGallery(atPlaceId)
        .then((list) => list.cast<String>())
        .catchError((e) {
      debugPrint('Cannot read gallery: ${e.toString()}');
      return Future<List<String>>.value([]);
    });

    await _firestore
        .collection('home_screen')
        .doc('gallery')
        .collection(atPlaceId)
        .doc('_')
        .set(
      {'imageUrls': imageUrls..addAll(gallery)},
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add Gallery to Place: ${e.toString()}');
    });
  }

  Future<void> removePlaceGalleryImage(
    String atPlaceId,
    String imageUrl,
  ) async {
    List<String> gallery = await readPlaceGallery(atPlaceId)
        .then((list) => list.cast<String>())
        .catchError((e) {
      debugPrint('Cannot read gallery: ${e.toString()}');
      return Future<List<String>>.value([]);
    });
    gallery.remove(imageUrl);

    await _firestore
        .collection('home_screen')
        .doc('gallery')
        .collection(atPlaceId)
        .doc('_')
        .set(
      {'imageUrls': gallery},
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add Gallery to Place: ${e.toString()}');
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> readPlaceGalleryExpressions(
    String atPlaceId,
    String galleryId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('gallery')
          .collection(atPlaceId)
          .doc(galleryId)
          .get()
          .catchError((e) {
        debugPrint(
            'Cannot retrieve Place Gallery expressions: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setPlaceGalleryExpressions(
    String atPlaceId,
    String galleryId,
    String? currentUserId, {
    required bool isLiked,
    required bool isDisliked,
    required bool isShared,
  }) async {
    final DocumentSnapshot? documentSnapshot =
        await readPlaceGalleryExpressions(atPlaceId, galleryId)
            .then((snapshot) => snapshot.exists ? snapshot : null);
    final List<String> likeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('likeUserIds') as List<dynamic>).cast<String>()
        : [];
    final List<String> dislikeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('dislikeUserIds') as List<dynamic>)
            .cast<String>()
        : [];
    final List<String> shareUserIds = documentSnapshot != null
        ? (documentSnapshot.get('shareUserIds') as List<dynamic>).cast<String>()
        : [];

    if (currentUserId != null) {
      if (isLiked && !likeUserIds.toString().contains(currentUserId)) {
        likeUserIds.add(currentUserId);
      } else if (!isLiked && likeUserIds.toString().contains(currentUserId)) {
        likeUserIds.remove(currentUserId);
      }
      if (isDisliked && !dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.add(currentUserId);
      } else if (!isDisliked &&
          dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.remove(currentUserId);
      }
    }
    if (isShared &&
        !shareUserIds.toString().contains(currentUserId.toString())) {
      shareUserIds.add(currentUserId.toString());
    }

    await _firestore
        .collection('home_screen')
        .doc('gallery')
        .collection(atPlaceId)
        .doc(galleryId)
        .set(
      {
        'likeUserIds': likeUserIds,
        'dislikeUserIds': dislikeUserIds,
        'shareUserIds': shareUserIds,
      },
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add expressions to Place Gallery: ${e.toString()}');
    });
  }

  Future<List<dynamic>> readPlaceViews(
    String atPlaceId,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('views')
          .collection('_')
          .doc(atPlaceId)
          .get()
          .then((documentSnapshot) =>
              documentSnapshot.exists ? documentSnapshot.get('viewers') : [])
          .catchError((e) {
        debugPrint('Cannot retrieve viewer data: ${e.toString()}');
      });

  Future<void> setViews4Place(
    String atPlaceId,
    String viewerId,
  ) async {
    List<dynamic> viewerIds = await readPlaceViews(atPlaceId).catchError((e) {
      debugPrint('Cannot read viewers: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (!viewerIds.toString().contains(viewerId)) {
      viewerIds.add(viewerId);
      await _firestore
          .collection('home_screen')
          .doc('views')
          .collection('_')
          .doc(atPlaceId)
          .set(
        {'viewers': viewerIds},
        SetOptions(merge: true),
      ).catchError((e) {
        debugPrint('Cannot add viewer to Place: ${e.toString()}');
      });
    }
  }

  // ProfileScreen
  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileData(
    String atUserId,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .get()
          .catchError((e) {
        debugPrint('Cannot retrieve profile data: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<bool> hasProfileData(
    String atUserId,
  ) async =>
      await getProfileData(atUserId)
          .then((documentSnapshot) => documentSnapshot.exists ? true : false);

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfilePrivacyData(
    String atUserId,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .collection('privacy_data')
          .doc('_')
          .get()
          .catchError((e) {
        debugPrint('Cannot retrieve profile privacy data: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> uploadProfileData(
    String atUserId,
    String dateTime,
    String? displayName,
    String? phoneNumber,
    String? profileUrl,
    String? backgroundUrl,
  ) async =>
      await _firestore.collection('profile_screen').doc(atUserId).set(
        {
          'userId': atUserId,
          'displayName': displayName,
          'phoneNumber': phoneNumber,
          'displayProfileUrl': profileUrl,
          'profileUrls': [profileUrl],
          'displayBackgroundUrl': backgroundUrl,
          'backgroundUrls': [backgroundUrl],
          'placeIds': [],
          'postIds': [],
          'boundUserIds': [],
          'dateTime': dateTime,
        },
        SetOptions(merge: false),
      ).catchError((e) {
        debugPrint('Cannot upload profile data: ${e.toString()}');
      });

  Future<void> uploadProfilePrivacyData(
    String atUserId,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .collection('privacy_data')
          .doc('_')
          .set(
        {
          'userId': atUserId,
          'aiName': ['', ''],
          'chats': [],
          'savedPlaceIds': [],
          'reviewedPlaceIds': [],
          'postIds': [],
        },
        SetOptions(merge: false),
      ).catchError((e) {
        debugPrint('Cannot upload profile privacy data: ${e.toString()}');
      });

  Future<void> updateProfileData(
    String atUserId,
    String key,
    dynamic value,
  ) async =>
      await _firestore.collection('profile_screen').doc(atUserId).update({
        key: value,
      }).catchError((e) {
        debugPrint('Cannot update profile data: ${e.toString()}');
      });

  Future<void> updateProfilePrivacyData(
    String atUserId,
    String key,
    dynamic value,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .collection('privacy_data')
          .doc('_')
          .update({
        key: value,
      }).catchError((e) {
        debugPrint('Cannot update profile privacy data: ${e.toString()}');
      });

  Future<List<dynamic>> _readFromProfileData(
    String atUserId, {
    required String type,
  }) async =>
      await getProfileData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get(type) : []);

  Future<DocumentSnapshot<Map<String, dynamic>>> readProfileExpressions(
    String atUserId,
    String galleryId,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .collection('expressions')
          .doc(galleryId)
          .get()
          .catchError((e) {
        debugPrint('Cannot retrieve Profile expressions: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setProfileExpressions(
    String atUserId,
    String galleryId,
    String? currentUserId, {
    required bool isLiked,
    required bool isDisliked,
    required bool isShared,
  }) async {
    final DocumentSnapshot? documentSnapshot =
        await readProfileExpressions(atUserId, galleryId)
            .then((snapshot) => snapshot.exists ? snapshot : null);
    final List<String> likeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('likeUserIds') as List<dynamic>).cast<String>()
        : [];
    final List<String> dislikeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('dislikeUserIds') as List<dynamic>)
            .cast<String>()
        : [];
    final List<String> shareUserIds = documentSnapshot != null
        ? (documentSnapshot.get('shareUserIds') as List<dynamic>).cast<String>()
        : [];

    if (currentUserId != null) {
      if (isLiked && !likeUserIds.toString().contains(currentUserId)) {
        likeUserIds.add(currentUserId);
      } else if (!isLiked && likeUserIds.toString().contains(currentUserId)) {
        likeUserIds.remove(currentUserId);
      }
      if (isDisliked && !dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.add(currentUserId);
      } else if (!isDisliked &&
          dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.remove(currentUserId);
      }
    }
    if (isShared &&
        !shareUserIds.toString().contains(currentUserId.toString())) {
      shareUserIds.add(currentUserId.toString());
    }

    await _firestore
        .collection('profile_screen')
        .doc(atUserId)
        .collection('expressions')
        .doc(galleryId)
        .set(
      {
        'likeUserIds': likeUserIds,
        'dislikeUserIds': dislikeUserIds,
        'shareUserIds': shareUserIds,
      },
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add expressions to Profile: ${e.toString()}');
    });
  }

  Future<void> addPlaceId2Profile(
    String atUserId,
    dynamic placeId,
  ) async {
    List<dynamic> placeIds =
        await _readFromProfileData(atUserId, type: 'placeIds').catchError((e) {
      debugPrint('Cannot read my placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (!placeIds.toString().contains(placeId.toString())) {
      placeIds.add(placeId.toString());
      await updateProfileData(atUserId, 'placeIds', placeIds);
    }
  }

  Future<void> deletePlaceIdFromProfile(
    String atUserId,
    dynamic atPlaceId,
  ) async {
    List<dynamic> placeIds =
        await _readFromProfileData(atUserId, type: 'placeIds').catchError((e) {
      debugPrint('Cannot read my placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (placeIds.toString().contains(atPlaceId.toString())) {
      placeIds.remove(atPlaceId.toString());
      await updateProfileData(atUserId, 'placeIds', placeIds);
    }
  }

  Future<List<dynamic>> readFromProfilePrivacyData(
    String atUserId, {
    required String type,
  }) async =>
      await getProfilePrivacyData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get(type) : []);

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserSavedPlaces(
    String enCountryName,
    String localeName,
    String atUserId,
  ) async {
    List<DocumentSnapshot<Map<String, dynamic>>> places = [];

    List<dynamic> placeIds =
        await readFromProfilePrivacyData(atUserId, type: 'savedPlaceIds')
            .catchError((e) {
      debugPrint('Cannot read Privacy Saved placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    for (var placeId in placeIds) {
      final place = await getPlaceData(enCountryName, localeName, placeId);
      if (place != null) places.add(place);
    }

    return places;
  }

  Future<void> addSavedPlaceId2Profile(
    String atUserId,
    dynamic placeId,
  ) async {
    List<dynamic> placeIds =
        await readFromProfilePrivacyData(atUserId, type: 'savedPlaceIds')
            .catchError((e) {
      debugPrint('Cannot read my saved placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (!placeIds.toString().contains(placeId.toString())) {
      placeIds.add(placeId.toString());
      await updateProfilePrivacyData(atUserId, 'savedPlaceIds', placeIds);
    }
  }

  Future<void> deleteSavedPlaceIdFromProfile(
    String atUserId,
    dynamic atPlaceId,
  ) async {
    List<dynamic> placeIds =
        await readFromProfilePrivacyData(atUserId, type: 'savedPlaceIds')
            .catchError((e) {
      debugPrint('Cannot read my saved placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (placeIds.toString().contains(atPlaceId.toString())) {
      placeIds.remove(atPlaceId.toString());
      await updateProfilePrivacyData(atUserId, 'savedPlaceIds', placeIds);
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserReviewedPlaces(
    String enCountryName,
    String localeName,
    String atUserId,
  ) async {
    List<DocumentSnapshot<Map<String, dynamic>>> places = [];

    List<dynamic> placeIds =
        await readFromProfilePrivacyData(atUserId, type: 'reviewedPlaceIds')
            .catchError((e) {
      debugPrint('Cannot read Privacy Reviewed placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    for (var placeId in placeIds) {
      final place = await getPlaceData(enCountryName, localeName, placeId);
      if (place != null) places.add(place);
    }

    return places;
  }

  Future<void> addReviewedPlaceId2Profile(
    String atUserId,
    dynamic placeId,
  ) async {
    List<dynamic> placeIds =
        await readFromProfilePrivacyData(atUserId, type: 'reviewedPlaceIds')
            .catchError((e) {
      debugPrint('Cannot read my reviewed placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (!placeIds.toString().contains(placeId.toString())) {
      placeIds.add(placeId.toString());
      await updateProfilePrivacyData(atUserId, 'reviewedPlaceIds', placeIds);
    }
  }

  Future<void> deleteReviewedPlaceIdFromProfile(
    String atUserId,
    dynamic atPlaceId,
  ) async {
    List<dynamic> placeIds =
        await readFromProfilePrivacyData(atUserId, type: 'reviewedPlaceIds')
            .catchError((e) {
      debugPrint('Cannot read my reviewed placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (placeIds.toString().contains(atPlaceId.toString())) {
      placeIds.remove(atPlaceId.toString());
      await updateProfilePrivacyData(atUserId, 'reviewedPlaceIds', placeIds);
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserPlaces(
    String enCountryName,
    String localeName,
    String atUserId,
  ) async {
    List<DocumentSnapshot<Map<String, dynamic>>> places = [];

    List<dynamic> placeIds =
        await _readFromProfileData(atUserId, type: 'placeIds').catchError((e) {
      debugPrint('Cannot read my placeIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    for (var placeId in placeIds) {
      final place = await getPlaceData(enCountryName, localeName, placeId);
      if (place != null) places.add(place);
    }

    return places;
  }

  Future<List<dynamic>> _readChats(
    String atUserId,
  ) async =>
      await getProfilePrivacyData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get('chats') : []);

  Future<void> addChat2Profile(
    String chatType,
    String userId,
    String chatId,
    String clientId,
  ) async {
    bool isRead = true;
    final List<dynamic> userChats = await _readChats(userId).catchError((e) {
      debugPrint('Cannot read previous user chats: ${e.toString()}');
      isRead = false;
      return Future<List<dynamic>>.value([]);
    });
    final List<dynamic> clientChats =
        await _readChats(clientId).catchError((e) {
      debugPrint('Cannot read previous client chats: ${e.toString()}');
      isRead = false;
      return Future<List<dynamic>>.value([]);
    });

    bool isExisted = false;
    for (Map<String, dynamic> userChat in userChats) {
      if (userChat['withUserId'].toString().contains(clientId) &&
          userChat['chatType'].toString().contains(chatType) &&
          userChat['chatId'].toString().contains(chatId)) isExisted = true;
    }
    if (isRead) {
      if (!isExisted) {
        userChats.add(
            {'chatId': chatId, 'withUserId': clientId, 'chatType': chatType});
        clientChats.add(
            {'chatId': chatId, 'withUserId': userId, 'chatType': chatType});
      }

      await updateProfilePrivacyData(userId, 'chats', userChats);
      await updateProfilePrivacyData(clientId, 'chats', clientChats);
    }
  }

  // ZoneScreen
  Future<DocumentSnapshot<Map<String, dynamic>>?> getPublicPostData(
    String enCountryName,
    String localeName,
    String atPostId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('public')
          .collection(enCountryName)
          .doc(localeName)
          .collection('modelProvinces.last.label')
          .doc(atPostId)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists && documentSnapshot.data()!.isNotEmpty) {
          return documentSnapshot;
        }
      }).catchError((e) {
        debugPrint('Cannot get Public Post data $atPostId: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setPublicPostData(
    String enCountryName,
    String localeName,
    String province,
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('public')
          .collection(enCountryName)
          .doc(localeName)
          .collection(province)
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        debugPrint('Cannot set merge Public Post data: ${e.toString()}');
      });

  Future<void> deletePublicPostData(
    String enCountryName,
    String localeName,
    String province,
    String atPostId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('public')
          .collection(enCountryName)
          .doc(localeName)
          .collection(province)
          .doc(atPostId)
          .delete()
          .catchError((e) {
        debugPrint('Cannot delete Public Post data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getPublicPosts(
    String enCountryName,
    String localeName,
    String province, [
    DocumentSnapshot? lastDoc,
  ]) async =>
      lastDoc != null
          ? await _firestore
              .collection('zone_screen')
              .doc('public')
              .collection(enCountryName)
              .doc(localeName)
              .collection(province)
              .orderBy('postId', descending: true)
              .startAfterDocument(lastDoc)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get Public Posts: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            })
          : await _firestore
              .collection('zone_screen')
              .doc('public')
              .collection(enCountryName)
              .doc(localeName)
              .collection(province)
              .orderBy('postId', descending: true)
              .limit(5)
              .get()
              .catchError((e) {
              debugPrint('Cannot get Public Posts: ${e.toString()}');
              return Future<QuerySnapshot<Map<String, dynamic>>>.error(e);
            });

  Future<DocumentSnapshot<Map<String, dynamic>>?> getPrivatePostData(
    String enCountryName,
    String localeName,
    String atUserId,
    String atPostId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('private')
          .collection(enCountryName)
          .doc(localeName)
          .collection(atUserId)
          .doc(atPostId)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists && documentSnapshot.data()!.isNotEmpty) {
          return documentSnapshot;
        }
      }).catchError((e) {
        debugPrint('Cannot get Private Post data $atPostId: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setPrivatePostData(
    String enCountryName,
    String localeName,
    String atUserId,
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('private')
          .collection(enCountryName)
          .doc(localeName)
          .collection(atUserId)
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        debugPrint('Cannot set merge Private Post data: ${e.toString()}');
      });

  Future<void> deletePrivatePostData(
    String enCountryName,
    String localeName,
    String atUserId,
    String atPostId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('private')
          .collection(enCountryName)
          .doc(localeName)
          .collection(atUserId)
          .doc(atPostId)
          .delete()
          .catchError((e) {
        debugPrint('Cannot delete Private Post data: ${e.toString()}');
      });

  Future<DocumentSnapshot<Map<String, dynamic>>> readPostExpressions(
    String atPostId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('expressions')
          .collection(atPostId)
          .doc('_')
          .get()
          .catchError((e) {
        debugPrint('Cannot retrieve Post expressions: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setPostExpressions(
    String atPostId,
    String? currentUserId, {
    required bool? boomState,
    required bool isDisliked,
    required bool isShared,
  }) async {
    final DocumentSnapshot? documentSnapshot =
        await readPostExpressions(atPostId)
            .then((snapshot) => snapshot.exists ? snapshot : null);
    final List<String> likeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('likeUserIds') as List<dynamic>).cast<String>()
        : [];
    final List<String> dislikeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('dislikeUserIds') as List<dynamic>)
            .cast<String>()
        : [];
    final List<String> shareUserIds = documentSnapshot != null
        ? (documentSnapshot.get('shareUserIds') as List<dynamic>).cast<String>()
        : [];

    if (currentUserId != null) {
      if (boomState == null) {
        try {
          likeUserIds.remove('${currentUserId}0');
          likeUserIds.remove('${currentUserId}1');
        } catch (e) {
          debugPrint("No boom items: ${e.toString()}");
        }
      } else if (boomState == false) {
        if (!likeUserIds.toString().contains('${currentUserId}0')) {
          likeUserIds.add('${currentUserId}0');
        }
        try {
          likeUserIds.remove('${currentUserId}1');
        } catch (e) {
          debugPrint("No boom items: ${e.toString()}");
        }
      } else {
        if (!likeUserIds.toString().contains('${currentUserId}0')) {
          likeUserIds.add('${currentUserId}0');
        }
        if (!likeUserIds.toString().contains('${currentUserId}1')) {
          likeUserIds.add('${currentUserId}1');
        }
      }
      if (isDisliked && !dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.add(currentUserId);
      } else if (!isDisliked &&
          dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.remove(currentUserId);
      }
    }
    if (isShared &&
        !shareUserIds.toString().contains(currentUserId.toString())) {
      shareUserIds.add(currentUserId.toString());
    }

    await _firestore
        .collection('zone_screen')
        .doc('expressions')
        .collection(atPostId)
        .doc('_')
        .set(
      {
        'likeUserIds': likeUserIds,
        'dislikeUserIds': dislikeUserIds,
        'shareUserIds': shareUserIds,
      },
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add expressions to Post: ${e.toString()}');
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> readPostGalleryExpressions(
    String atPostId,
    String galleryId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('expressions')
          .collection(atPostId)
          .doc(galleryId)
          .get()
          .catchError((e) {
        debugPrint('Cannot retrieve Post Gallery expressions: ${e.toString()}');
        return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
      });

  Future<void> setPostGalleryExpressions(
    String atPostId,
    String galleryId,
    String? currentUserId, {
    required bool isLiked,
    required bool isDisliked,
    required bool isShared,
  }) async {
    final DocumentSnapshot? documentSnapshot =
        await readPostGalleryExpressions(atPostId, galleryId)
            .then((snapshot) => snapshot.exists ? snapshot : null);
    final List<String> likeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('likeUserIds') as List<dynamic>).cast<String>()
        : [];
    final List<String> dislikeUserIds = documentSnapshot != null
        ? (documentSnapshot.get('dislikeUserIds') as List<dynamic>)
            .cast<String>()
        : [];
    final List<String> shareUserIds = documentSnapshot != null
        ? (documentSnapshot.get('shareUserIds') as List<dynamic>).cast<String>()
        : [];

    if (currentUserId != null) {
      if (isLiked && !likeUserIds.toString().contains(currentUserId)) {
        likeUserIds.add(currentUserId);
      } else if (!isLiked && likeUserIds.toString().contains(currentUserId)) {
        likeUserIds.remove(currentUserId);
      }
      if (isDisliked && !dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.add(currentUserId);
      } else if (!isDisliked &&
          dislikeUserIds.toString().contains(currentUserId)) {
        dislikeUserIds.remove(currentUserId);
      }
    }
    if (isShared &&
        !shareUserIds.toString().contains(currentUserId.toString())) {
      shareUserIds.add(currentUserId.toString());
    }

    await _firestore
        .collection('zone_screen')
        .doc('expressions')
        .collection(atPostId)
        .doc(galleryId)
        .set(
      {
        'likeUserIds': likeUserIds,
        'dislikeUserIds': dislikeUserIds,
        'shareUserIds': shareUserIds,
      },
      SetOptions(merge: true),
    ).catchError((e) {
      debugPrint('Cannot add expressions to Post Gallery: ${e.toString()}');
    });
  }

  Future<Map<String, dynamic>> readPostSearchData(
    String enCountryName,
    String localeName,
  ) async {
    int segment = 0;
    bool shouldStop = false;
    Map<String, dynamic> data = {};
    do {
      data = {
        ...data,
        ...(await _firestore
            .collection('zone_screen')
            .doc('searches')
            .collection(enCountryName)
            .doc(localeName)
            .collection('segments')
            .doc(segment.toString())
            .get()
            .catchError((e) {
          shouldStop = true;
          return Future<DocumentSnapshot<Map<String, dynamic>>>.error(e);
        }).then((documentSnapshot) {
          if (documentSnapshot.exists) {
            return documentSnapshot.data()!;
          } else {
            shouldStop = true;
            return {};
          }
        }))
      };
      segment++;
    } while (!shouldStop);
    return data;
  }

  Future<void> setPostSearchData(
    String enCountryName,
    String localeName,
    String key,
    String postId,
  ) async {
    Map<String, dynamic> searches =
        await readPostSearchData(enCountryName, localeName).catchError((e) {
      debugPrint('Cannot read search post data: ${e.toString()}');
      return Future<Map<String, dynamic>>.value({});
    });
    searches[key] = postId;
    for (int segment = 0; segment <= searches.length ~/ 200; segment++) {
      await _firestore
          .collection('zone_screen')
          .doc('searches')
          .collection(enCountryName)
          .doc(localeName)
          .collection('segments')
          .doc(segment.toString())
          .set(Map.fromEntries(
              searches.entries.skip(segment * 200).take((segment + 1) * 200)))
          .catchError((e) {
        debugPrint('Cannot add search post data to firestore: $e');
      });
    }
  }

  Future<void> deletePostSearchData(
    String enCountryName,
    String localeName,
    String key,
  ) async {
    Map<String, dynamic> searches =
        await readPostSearchData(enCountryName, localeName).catchError((e) {
      debugPrint('Cannot read search post data: ${e.toString()}');
      return Future<Map<String, dynamic>>.value({});
    });
    searches.remove(key);
    for (int segment = 0; segment <= searches.length ~/ 200; segment++) {
      await _firestore
          .collection('zone_screen')
          .doc('searches')
          .collection(enCountryName)
          .doc(localeName)
          .collection('segments')
          .doc(segment.toString())
          .set(Map.fromEntries(
              searches.entries.skip(segment * 200).take((segment + 1) * 200)))
          .catchError((e) {
        debugPrint('Cannot delete search post data from firestore: $e');
      });
    }
  }

  Future<List<dynamic>> _readPublicPostIds(
    String atUserId,
  ) async =>
      await getProfileData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get('postIds') : []);

  Future<List<dynamic>> _readPrivatePostIds(
    String atUserId,
  ) async =>
      await getProfilePrivacyData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get('postIds') : []);

  Future<void> addPublicPostId2Profile(
    String atUserId,
    dynamic postId,
  ) async {
    List<dynamic> postIds = await _readPublicPostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Public postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (!postIds.toString().contains(postId.toString())) {
      postIds.add(postId.toString());
      await updateProfileData(atUserId, 'postIds', postIds);
    }
  }

  Future<void> addPrivatePostId2Profile(
    String atUserId,
    dynamic postId,
  ) async {
    List<dynamic> postIds = await _readPrivatePostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Private postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (!postIds.toString().contains(postId.toString())) {
      postIds.add(postId.toString());
      await updateProfilePrivacyData(atUserId, 'postIds', postIds);
    }
  }

  Future<void> deletePublicPostIdFromProfile(
    String atUserId,
    dynamic atPostId,
  ) async {
    List<dynamic> postIds = await _readPublicPostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Public postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (postIds.toString().contains(atPostId.toString())) {
      postIds.remove(atPostId.toString());
      await updateProfileData(atUserId, 'postIds', postIds);
    }
  }

  Future<void> deletePrivatePostIdFromProfile(
    String atUserId,
    dynamic atPostId,
  ) async {
    List<dynamic> postIds = await _readPrivatePostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Private postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    if (postIds.toString().contains(atPostId.toString())) {
      postIds.remove(atPostId.toString());
      await updateProfilePrivacyData(atUserId, 'postIds', postIds);
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getSpecificUserPosts(
    String enCountryName,
    String localeName,
    String atUserId,
    int loadTimes, {
    int length = 3,
  }) async {
    List<DocumentSnapshot<Map<String, dynamic>>> posts = [];

    final List<dynamic> publicPostIds =
        await _readPublicPostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Public postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    final List<String> postIds = publicPostIds.cast<String>()
      ..sort((a, b) => b.compareTo(a));

    for (int index = loadTimes * length; index < postIds.length; index++) {
      if (index < (loadTimes + 1) * length) {
        final post = await getPublicPostData(
            enCountryName, localeName, postIds.elementAt(index));
        if (post != null) posts.add(post);
      }
    }

    return posts;
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserPosts(
    String enCountryName,
    String localeName,
    String atUserId,
    int loadTimes, {
    int length = 5,
  }) async {
    List<DocumentSnapshot<Map<String, dynamic>>> posts = [];

    final List<dynamic> publicPostIds =
        await _readPublicPostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Public postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    final List<dynamic> privatePostIds =
        await _readPrivatePostIds(atUserId).catchError((e) {
      debugPrint('Cannot read my Private postIds: ${e.toString()}');
      return Future<List<dynamic>>.value([]);
    });
    final List<String> postIds = [
      ...publicPostIds.cast<String>(),
      ...privatePostIds.cast<String>()
    ]..sort((a, b) => b.compareTo(a));

    for (int index = loadTimes * length; index < postIds.length; index++) {
      if (index < (loadTimes + 1) * length) {
        if (publicPostIds.toString().contains(postIds.elementAt(index))) {
          final post = await getPublicPostData(
              enCountryName, localeName, postIds.elementAt(index));
          if (post != null) posts.add(post);
        } else if (privatePostIds
            .toString()
            .contains(postIds.elementAt(index))) {
          final post = await getPrivatePostData(
              enCountryName, localeName, atUserId, postIds.elementAt(index));
          if (post != null) posts.add(post);
        }
      }
    }

    return posts;
  }

  Future<List<dynamic>> readPostViews(
    String localeName,
    String postId,
  ) async =>
      await _firestore
          .collection('zone_screen')
          .doc('views')
          .collection(localeName)
          .doc(postId)
          .get()
          .then((documentSnapshot) =>
              documentSnapshot.exists ? documentSnapshot.get('viewers') : [])
          .catchError((e) {
        debugPrint('Cannot retrieve viewer data: ${e.toString()}');
      });

  Future<void> setViews4Posts(
    String localeName,
    String viewerId,
    List<String> postIds,
  ) async {
    try {
      for (String postId in postIds) {
        List<dynamic> viewerIds =
            await readPostViews(localeName, postId).catchError((e) {
          debugPrint('Cannot read post viewers: ${e.toString()}');
          return Future<List<dynamic>>.error("Error Post Viewers");
        });
        if (!viewerIds.toString().contains(viewerId)) {
          viewerIds.add(viewerId);
          await _firestore
              .collection('zone_screen')
              .doc('views')
              .collection(localeName)
              .doc(postId)
              .set(
            {'viewers': viewerIds},
            SetOptions(merge: true),
          ).catchError((e) {
            debugPrint('Cannot add viewer to Post: ${e.toString()}');
          });
        }
      }
    } catch (e) {
      debugPrint('Error add viewer to Posts: ${e.toString()}');
    }
  }

  // ChatScreen
  Future<void> addChatMessage(
    String atUserId,
    String atClientId,
    String atChatId,
    String? message,
    String? attachmentUrl,
  ) async {
    final String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore
        .collection('chat_screen')
        .doc(atUserId)
        .collection(atChatId)
        .doc('withUserId')
        .collection(atClientId)
        .add({
      'senderUid': atUserId,
      'message': message ?? '',
      'attachmentUrl': attachmentUrl ?? '',
      'dateTime': dateTime,
    }).catchError((e) {
      debugPrint('Cannot add user message: ${e.toString()}');
      return Future<DocumentReference<Map<String, dynamic>>>.error(e);
    });
    await _firestore
        .collection('chat_screen')
        .doc(atClientId)
        .collection(atChatId)
        .doc('withUserId')
        .collection(atUserId)
        .add({
      'senderUid': atUserId,
      'message': message ?? '',
      'attachmentUrl': attachmentUrl ?? '',
      'dateTime': dateTime,
    }).catchError((e) {
      debugPrint('Cannot add client message: ${e.toString()}');
      return Future<DocumentReference<Map<String, dynamic>>>.error(e);
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfilePrivacy(
    String atUserId,
  ) =>
      _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .collection('privacy_data')
          .doc('_')
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    String atUserId,
    String atChatId,
    String withUserId, {
    int? messageQuantity,
  }) =>
      messageQuantity != null
          ? _firestore
              .collection('chat_screen')
              .doc(atUserId)
              .collection(atChatId)
              .doc('withUserId')
              .collection(withUserId)
              .orderBy('dateTime', descending: true)
              .limit(messageQuantity)
              .snapshots()
          : _firestore
              .collection('chat_screen')
              .doc(atUserId)
              .collection(atChatId)
              .doc('withUserId')
              .collection(withUserId)
              .orderBy('dateTime', descending: true)
              .snapshots();
}
