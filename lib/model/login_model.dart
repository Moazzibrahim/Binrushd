class LoginResponse {
  final String message;
  final UserData data;

  LoginResponse({required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final User user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String fname;
  final String lname;
  final String fullName;
  final String email;
  final String mobile;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String token;
  final List<Reservation> reservations;

  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
    required this.reservations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      fullName: json['full_name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      token: json['token'],
      reservations: (json['reservations'] as List)
          .map((e) => Reservation.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'full_name': fullName,
      'email': email,
      'mobile': mobile,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'token': token,
      'reservations': reservations.map((e) => e.toJson()).toList(),
    };
  }
}

class Reservation {
  final int id;
  final Customer customer;
  final dynamic servey;
  final int isOffer;
  final Offer offer;
  final Branch branch;
  final dynamic doctor;

  Reservation({
    required this.id,
    required this.customer,
    this.servey,
    required this.isOffer,
    required this.offer,
    required this.branch,
    this.doctor,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      servey: json['servey'],
      isOffer: json['isOffer'],
      offer: Offer.fromJson(json['offer']),
      branch: Branch.fromJson(json['branch']),
      doctor: json['doctor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer.toJson(),
      'servey': servey,
      'isOffer': isOffer,
      'offer': offer.toJson(),
      'branch': branch.toJson(),
      'doctor': doctor,
    };
  }
}

class Customer {
  final String name;
  final String email;
  final String phone;

  Customer({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}

class Offer {
  final int id;
  final String title;
  final String description;
  final String image;
  final int active;
  final int updatedBy;
  final String createdAt;
  final String updatedAt;
  final String startTime;
  final String endTime;
  final int isSlider;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.active,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.startTime,
    required this.endTime,
    required this.isSlider,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      active: json['active'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isSlider: json['isSlider'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'active': active,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'startTime': startTime,
      'endTime': endTime,
      'isSlider': isSlider,
    };
  }
}

class Branch {
  final int id;
  final String name;
  final String image;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final String brief;
  final String address;
  final double latitude;
  final double longitude;
  final String worktimes;
  final int active;
  final String email;

  Branch({
    required this.id,
    required this.name,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.brief,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.worktimes,
    required this.active,
    required this.email,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      brief: json['brief'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      worktimes: json['worktimes'],
      active: json['active'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'brief': brief,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'worktimes': worktimes,
      'active': active,
      'email': email,
    };
  }
}
