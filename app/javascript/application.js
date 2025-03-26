// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"



window.addEventListener("resize", function() {
  if (window.innerWidth < 768) {
    console.log("Mobile view");
  } else {
    console.log("Desktop view");
  }
});

// Optional: Run on initial load to detect the screen size immediately
if (window.innerWidth < 768) {
  console.log("Mobile view");
} else {
  console.log("Desktop view");
}
