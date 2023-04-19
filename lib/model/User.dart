// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Sigin {
  String? username;
  String? password;
  Sigin({
    this.username,
    this.password,
  });

  @override
  String toString() => 'Sigin(username: $username, password: $password)';
}

class User {
  int? id;
  String? username;
  String? password;
  String? email;
  String? role;
  String? firstName;
  String? lastName;
  String? address;
  User({
    this.id,
    this.username,
    this.password,
    this.email,
    this.role,
    this.firstName,
    this.lastName,
    this.address,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, email: $email, role: $role, firstName: $firstName, lastName: $lastName, address: $address)';
  }
}

class UserLogin {
  String? token;
  int? id;
  String? username;
  String? email;
  String? fullName;
  List<String>? roles;
  UserLogin({
    this.token,
    this.id,
    this.username,
    this.email,
    this.fullName,
    this.roles,
  });
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      token: json['token'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      roles: List<String>.from(json['roles']),
    );
  }

  @override
  String toString() {
    return 'UserLogin(token: $token, id: $id, username: $username, email: $email, fullName: $fullName, roles: $roles)';
  }
}

class UserSignUp {
  int? id;
  String? username;
  String? email;
  String? roles;
  String? password;

  UserSignUp({
    this.id,
    this.username,
    this.email,
    this.roles,
    this.password,
  });
  factory UserSignUp.fromJson(Map<String, dynamic> json) {
    return UserSignUp(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: json['roles'],
      password: json['password'],
    );
  }

  @override
  String toString() {
    return 'UserSignUp(id: $id, username: $username, email: $email, roles: $roles, password: $password)';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'roles': roles,
      'password': password,
    };
  }
}
