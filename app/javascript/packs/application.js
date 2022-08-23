// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'
import "chartkick"
import "chart.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ユーザー写真の編集動作

$(window).on('turbolinks:load', function() {
  $(function() {
    const uploader = document.querySelector('.uploader');
    uploader.addEventListener('change', (e) => {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const image = reader.result;
        document.querySelector('.avatar').setAttribute('src', image);
      }
    });
  });
});

// タブの切り替え
/*global $*/
$(document).on('turbolinks:load', function() {
  $(function() {
    $('.tab').click(function(){
      $('.tab-active').removeClass('tab-active');
      $(this).addClass('tab-active');
      $('.box-show').removeClass('box-show');
      const index = $(this).index();
      $('.tabbox').eq(index).addClass('box-show');
    });
  });
});

$(function(){
  $('#hello').fadeOut(5000);
});