// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import 'flowbite';
import "controllers"

import "nice-select2"
import "trix"
import "@rails/actiontext"

import jQuery from "jquery"
window.jQuery = jQuery
window.$ = jQuery 

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
