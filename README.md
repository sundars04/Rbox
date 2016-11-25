This is a simple Recipe website built using RoR.
Users can login, View, create, update and delete recipes(CRUD), users can also comment in a threaded patter using acts_as_commentable_with_threading gem.

Things you may want to cover:

* Ruby version - 2.3.0

* Rails version - 5.0.0.1

* Additional gems used - haml, simple_form, bootstrap-sass, devise, devise-bootstrapped(for login, update and signup)
	paperclip(image upload), cocoon(nested forms), acts_as_commentable_with_threading(for comments) and aws-sdk(for heroku)

* Database - pg for production

* Deployment instructions - git clone, bundle install --without production, rails db:migrate and rails s

* Deployment instructions for Heroku - you will need to add aws config settings in heroku(bucket, region, access and secret key).
