// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import 'flowbite';
import "controllers"

import "nice-select2"
import "aos";
import "trix"
import "@rails/actiontext"

import jQuery from "jquery"
import AOS from 'aos';
window.jQuery = jQuery
window.$ = jQuery 

document.addEventListener('turbo:load', () => { AOS.init({offset: 300, delay: 100}) });


function initializeNiceSelect(){
  var selectElements = document.querySelectorAll("select.selectable");
  selectElements.forEach((element) => {
    var nextSibling = element.nextElementSibling;
    if(nextSibling && nextSibling.classList.contains('nice-select')){
      
    }else{
      NiceSelect.bind(element, {searchable: true});
    }
  });
}


document.addEventListener("turbo:load", () => {
  initializeNiceSelect()
});

document.addEventListener("turbo:frame-load", () => {
  initializeNiceSelect()
});
window.initializeNiceSelect = initializeNiceSelect
