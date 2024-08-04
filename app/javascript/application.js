// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import 'flowbite';
import "controllers"

import "trix"
import "@rails/actiontext"

import jQuery from "jquery"
window.jQuery = jQuery
window.$ = jQuery 

console.log("hello from application.js -----------")
document.addEventListener('DOMContentLoaded', () => {
  console.log('dom loaded...................................... ')
  const toggleButton = document.getElementById('dark-mode-toggle');
  const bodyElement = document.body;

  // Apply dark mode based on localStorage
  if (localStorage.getItem('theme') === 'dark' || 
      (!localStorage.getItem('theme') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    bodyElement.classList.add('dark');
    console.log('dark mode on ======   for local storage =============================')
  } else {
    bodyElement.classList.remove('dark');
    console.log('dark mode off ===== for local storage ============================')
  }

  // Toggle dark mode on button click
  toggleButton.addEventListener('click', () => {
    console.log('clicked=========...................')
    bodyElement.classList.toggle('dark');
    // Save the preference in localStorage
    if (bodyElement.classList.contains('dark')) {
      localStorage.setItem('theme', 'dark');
      console.log('dark mode on ==========    for click============================================')
    } else {
      localStorage.setItem('theme', 'light');
      console.log('dark mode off ========  for click =============')
    }
  });
});
