# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   r.match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   r.match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   r.match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
  r.resources :videos, :member => {:form => :get, :upload => :post, :done => :get, :state => :get, :add_to_queue => :get }, :collection => {:exp => :get} do |video|
    video.resource :thumbnail
    # Using get requests right now for create and update
    video.match('/thumbnail/create').to(:controller => "thumbnail", :action => "create")
    video.match('/thumbnail/update').to(:controller => "thumbnail", :action => "update")
  end
  
  r.match("/videos/form").to(:controller => "videos", :action => "upload_form")
  r.match("/signup").to(:controller => "accounts", :action => "new")
  r.match("/login").to(:controller => "auth", :action => "login")
  r.match("/logout").to(:controller => "auth", :action => "logout")
  
  # This is the default route for /:controller/:action/:id
  # This is fine for most cases.  If you're heavily using resource-based
  # routes, you may want to comment/remove this line to prevent
  # clients from calling your create or destroy actions with a GET
  # r.default_routes
  r.match("/").to(:controller => "dashboard", :action => "index")
end
