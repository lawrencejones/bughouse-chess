# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.signup-form').validate
    rules:
      name:
        required: true
        minlength: 3
      email:
        required: true
        email: true
      password:
        required: true
        minlength: 6
      password_confirmation:
        required: true
        equalTo: "#password"
    messages:
      name:
        required: "Please input your nickname"
        minlength: "Your name should be at least 3 characters long"
      email:
        required: "Please input your valid input address"
        email: "Your email address must be in the format of name@domain.com"
      password:
        required: "Please input your password"
        minlength: "Your password should be at least 6 characters long"
      password_confirmation:
        requited: "Please confirm your password"  
  return