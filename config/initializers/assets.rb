# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(
  main/vendors/animate.css
  main/vendors/bootstrap.min.css
  main/vendors/chosen.css
  main/vendors/dashboard.css
  main/vendors/dbresponsive.css
  main/vendors/font-awesome.min.css
  main/vendors/fontawesome-all.css
  main/vendors/fullcalendar.min.css
  main/vendors/icomoon.css
  main/vendors/jquery-ui.css
  main/vendors/linearicons.css
  main/vendors/normalize.css
  main/vendors/owl.carousel.min.css
  main/vendors/scrollbar.css
  main/vendors/themify-icons.css
  main/vendors/transitions.css
  toastui-calendar.min.css
  toastr.css

  jquery.js
  jquery_ujs.js
  main.js
  toastui-calendar.min.js
  toastr.min.js
  vendors/modernizr-2.8.3-respond-1.4.2.min.js
)
