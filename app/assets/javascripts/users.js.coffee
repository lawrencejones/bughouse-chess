# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#signup-form').validate
    errorClass: 'danger'
    rules:
      'user[name]': 'required'
      'user[email]':
        required: true
        email: true
      'user[password]':
        required: true
        minlength: 6
      'user[password_confirmation]':
        required: true
        equalTo: "#password"
    messages:
      'user[name]':
        required: "Please input your nickname"
        minlength: "Your name should be at least 3 characters long"
      'user[email]':
        required: "Please input your valid input address"
        email: "Your email address must be in the format of name@domain.com"
      'user[password]':
        required: "Please input your password"
        minlength: "Your password should be at least 6 characters long"
      'user[password_confirmation]':
        requited: "Please confirm your password"


