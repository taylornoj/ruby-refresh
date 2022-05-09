Notes from https://www.railstutorial.org/book tutorial



| File/Directory  |     Purpose |
| --- | --- |
| app/ |	Core application (app) code, including models, views, controllers, and helpers |
| app/assets |	Applications assets such as Cascading Style Sheets (CSS) and images |
| bin/	| Binary executable files |
| config/ |	Application configuration |
|db/ |	Database files |
|doc/	 | Documentation for the application
| lib/ |	Library modules |
| log/	| Application log files |
| public/	| Data accessible to the public (e.g., via web browsers), such as error pages |
| bin/rails |	A program for generating code, opening console sessions, or starting a local server |
| test/	| Application tests |
| tmp/ |	Temporary files |
| Gemfile |	Gem requirements for this app |
| Gemfile.lock |	A list of gems used to ensure that all copies of the app use the same gem versions |
| config.ru |	A configuration file for Rack middleware |



BUNDLER
Unless you specify a version number to the gem command, Bundler will automatically install the latest requested version of the gem. This is the case, for example, in the code

gem 'spring'

There are also two common ways to specify a gem version range, which allows us to exert some control over the version used by Rails. The first looks like this:

gem 'capybara', '>= 3.26'

This installs the latest version of the capybara gem (which is used in testing) as long as it’s greater than or equal to version 3.26—even if it’s, say, version 7.2.

The second method looks like this:

gem 'sqlite3', '~> 1.4'
This installs the gem sqlite3 as long as it’s version 1.4 or newer but not 2 or newer. In other words, the >= notation always installs the latest gem as long as it meets the minimum version requirement, whereas the ~> 1.4 notation will install 1.5 (if available) but not 2.0.10

***

MVC - model view controller
MVC artchitectural pattern - enforces a separation between the data
in the application (such as user information) and the code to display it, which
is a common way of structuring a graphical user interface (GUI)

In Rails apps:
browser sends a request
then it's received by webserver, 
passed to Rails controller - which is in charge of what to do next
the controller can immediately render a view (template > HTML > browser)
OR
for dynamic sites, controller interats with model
model = a ruby object representing element on the site (ie user)
and this is in charge of communicating with the database
after invoking model, the controller then renders the view
& returns complete web page to browser as HTML

![mvc](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/mvc_schematic.png)

App #1 - Hello, world!
add a controller action to render the string "hello, world!" to replace default Rails page

Notes: controller actions are defined inside controllers. Our action is 'hello' and we place it in the application controller

see all controllers by running
ls app/controllers/*_controller.rb

controller:
class ApplicationController < ActionController::Base

  def hello
    render html: "hello, world!"
  end
end

So having defined an action that returns the desired string, we need to tells Rails to use that action instead of the default page

To do this, we edit the Rails router ( determines where to send requests that come in from the browser)

In particular, we want to change the default page, the root route, which determines the page that is served on the root URL.

how to define the root route:
syntax = 
root 'controller_name#action_name'

In the present case, the controller name is application and the action name is hello

config/routes.rb
Rails.application.routes.draw do
  root 'application#hello'
end

And then we see hello, world! in the browser


***
Toy App

The typical first step when making a web application is to create a data model, which is a representation of the structures needed by our application, including the relationships between them.

![users data model](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/demo_user_model.png)

Recall from the introduction that a micropost is simply a short post, essentially a generic term for the brand-specific “tweet” (with the prefix “micro” motivated by Twitter’s original description as a “micro-blog”).

we want to associate each micropost with a particular user. We’ll accomplish this by recording the user_id of the owner of the post.

![micropost data model](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/demo_micropost_model.png)

we’ll implement the users data model in Section 2.1.1, along with a web interface to that model. The combination will constitute a Users resource, which will allow us to think of users as objects that can be created, read, updated, and deleted through the web via the HTTP protocol.

our Users resource will be created by a scaffold generator program, which comes standard with each Rails project

Rails scaffolding is generated by passing the scaffold command to the rails generate script.

SCAFFOLDING
- a quick way to generate some of the major pieces of an application - if you want to create mvc for a new resource in a single operation, scaffolding is the tool for the job
Scaffolding generator will create several files for things like the post model, routing for posts, posts controller, views to display index, edit, create, etc

The argument of the scaffold command is the singular version of the resource name (in this case, User), together with optional parameters for the data model’s attributes:

```rails generate scaffold User name:string email:string```

There is no need to include a parameter for id as it is created automatically by Rails for use as primary key in database

then migrate db
```rails db:migrate```

```ruby
== CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.0027s
== CreateUsers: migrated (0.0036s) =============================
```

![going to users at end of HTML](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/demo_blank_user_index.png)

![add new user](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/demo_new_user.png)

Once you create a new user you are brought to that user page -The result is the user show page at /users/1. This page will become the users profile page

results of the browser hit
![mvc flow](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/mvc_detailed.png)

1. Browswer issues request for /users URL

2. Rails routes/users to the ```index``` action in the users controller:

```ruby
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  ```
  (This request hits the Rails router (Step 2), which dispatches the request to the proper controller action based on the URL )

  3. ```index``` action asks User model to retrieve all users (User.all)
  
  4. User model pulls all users from the database
  ```ruby
  # user.rb

  class User < ApplicationRecord
end
```

5. The User model returns list of users to controller
-- The code to create the mapping of user URLs to controller actions for the Users resource appears:
```ruby
# config/routes.rb

Rails.application.routes.draw do
  resources :users
  root 'application#hello'
end
```

6. controller captures users in @users variable which is passed to the index view
[[A controller contains a collection of related actions]]

```ruby
  <tbody>
    <% @users.each do |user| %>
      <tr>
        <td><%= user.name %></td>
        <td><%= user.email %></td>
        <td><%= link_to 'Show', user %></td>
        <td><%= link_to 'Edit', edit_user_path(user) %></td>
        <td><%= link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
  ```

  7. The view uses embedded Ruby to render page as HTML

8. Controller passes HTML back to the browser



*This full suite of controller actions below, represents the implementation of the REST architecture in Rails (based on the ideas of representational state transfer):*



| HTTP request method	| URL	| Action | Purpose |
| ------ | --- | --- | --- |
| GET	| /users |	index	| page to list all users |
| GET	| /users/1 |	show |	page to show user with id 1 |
| GET |	/users/new |	new	| page to make a new user |
| POST |	/users |	create	| create a new user |
| GET	| /users/1/edit |	edit |	page to edit user with id 1 |
| PATCH	| /users/1 |	update |	update user with id 1 |
| DELETE	| /users/1 |	destroy |	delete user with id 1

There is some overlap - like in ```show``` and ```update``` actions where URL is users/1; the difference between them is the HTTP request method they respond to (GET, POST, PUT, DELETE, etc)


**REST**

REpresentational State Transfer: an architectural style for developing distributed, networked systems and software applications such as the World Wide Web and web applications 

in the context of Rails applications REST means that most application components (such as users and microposts) are modeled as resources that can be created, read, updated, and deleted -- operations that correspond both to the CRUD operations of relational databases and to the four fundamental HTTP request methods: POST, GET, PATCH, and DELETE

As a Rails application developer, the RESTful style of development helps you make choices about which controllers and actions to write: you simply structure the application using resources that get created, read, updated, and deleted.

***
```ruby
app/controllers/users_controller.rb

class UsersController < ApplicationController
  .
  .
  def index
    @users = User.all
  end
  .
  .
end
```

The index action asks the User model to retrieve a list of all the users from the database, then places them in the variable @users

The User model itself is in ```app/models/user.rb```
```ruby
class User < ApplicationRecord
end
```

Doesn't seem like much but there is high functionality because of inheritance - from library Active Record.  So the above in user.rb arranges for User.all to return all users in the db

Once the @users variable is defined, the controller calls the view [app/views/users/index.html.erb]

```ruby
<h1>Users</h1>

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Email</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @users.each do |user| %>
      <tr>
      .
      .
```

variables that start with @ are called instance variables.  They are automtically available in views. In this case, the @users list is iterated through and a line of HTML is outputted for each user

So the view converts its contents to HTML which is then returned by the controller to the browser for display


***

Then we create microposts in the same way as users, with scaffold and then migrate db

```rails generate scaffold Micropost content:text user_id:integer```

```rails db:migrate```

Microposts resource gets a new rule

```ruby
Rails.application.routes.draw do
  resources :microposts
  resources :users
  root 'users#index'
end
```
and the same controller actions as users, GET, POST, etc

go to microposts/new:
![new microposts page](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/demo_new_micropost.png)

**enforcing length of the post**

Add the validates to:
```ruby
# app/models/micropost.rb
class Micropost < ApplicationRecord
  validates :content, length: { maximum: 140 }
end
```

Then if we try to enter more than 140 we get an error message:

![error message > 140 char](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/micropost_length_error.png)

Then we need to form **associations**:
between data models - ex. User model, each user potentially has many microposts so we need to update our code to reflect that:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_many :microposts
end
```

```ruby
# app/models/micropost.rb
class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 140 }
end

```

Question:
Edit the user show page to display the content of the user’s first micropost

add to show in users_controller.rb:
```ruby
 def show
    @user = User.find(params[:id])
    @micropost = @user.microposts.first # returns users first post
  end
  # so you have to check if @micropost is nil before displaying it in the view
  ```

  then in show.html.erb ...

```ruby
<% if @micropost %> 
  <p>
    <strong>Content:</strong>
    <%= @micropost.content %>
  </p>
<% end %>
```

***

Inheritance - 

Both Users and Micropost models inherit from < ApplicationRecord, which in turn inherits from ActionRecord::Base (the base class for models provided by Active Record)

By inheriting from ActionRecord::Base, our model objects gain ability to communicate with the db/treat db columns as Ruby attributes, etc

Inheritance hierarchy
![inheritance hierarchy](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_6th_edition/images/figures/demo_model_inheritance_4th_ed.png)

Users and Microposts controllers gain functionality by inheriting from a base class:
- ability to manipulate model objects
- filter inbound HTTP requests
- render views as HTML

*Lessons*
- Scaffolding automatically creates code to model data and interact with it through the web.

- Rails uses the Model-View-Controller (MVC) pattern for structuring web applications

- As interpreted by Rails, the REST architecture includes a standard set of URLs and controller actions for interacting with data models

***

Static Pages
First step is to generate a controller using ```generate``` script - like generating scaffolding

```ruby
rails generate controller StaticPages home help
```

***
Command Shortcuts:

```rails server``` => ```rails s```

```rails console``` => ```rails c```

```rails generate``` => ```rails g```

```rails test``` => ```rails t```

```bundle install``` => ```bundle```


TIPS:

New routes are defined in the file config/routes.rb

Rails views can contain static HTML or embedded Ruby (ERb).

* undoing code generations, ie you need to change the name of a controller and elim generated files

use ```rails destroy```

example:
```ruby
 $ rails generate controller StaticPages home help
 $ rails destroy  controller StaticPages home help
  ```

  and if you need to destroy a model:

  ```ruby
  $ rails generate model User name:string email:string
  $ rails destroy model User
  ```

Undoing migrations:

migrations change the state of the database using the command:
``` $ rails db:migrate```

we can undo a single migration step using
```$ rails db:rollback```

to go back to very beginning
``` $ rails db:migrate VERSION=0```

**HTTP**
Hypertext Transfer Protocol defines basic operations GET, POST, PATCH and DELETE

These are operations between a client computer (on Chrome, Firefox, etc) and a server (webserver like Apache, Nginx)

GET - most common. 'Get a page'.
POST - request sent by your browser when you submit a form. In Rails, POST requests are used for creating things (HTTP also allows POST to perform updates). POST request send when you submit a registration form creates a new user on the remote side
PATCH and DELETE - designed for updating and destroying things on the remote servver

***

classes are a convenient way to organize functions (methods) 
***
TDD:
write failing tests first

why to test:

1. test protect again regressions - functioning feature stores working for some reason

2. test allow code to be refactored with more confidence

3. tests act as a client for application code, help to determine its design and interface with other parts of the system

generating a controller also generates a test file
```static_pages_controller_test.rb```

To run the test:
```ruby
$ rails db:migrate     # Necessary on some systems
$ rails test
2 tests, 2 assertions, 0 failures, 0 errors, 0 skips
```

You can test for presence of an HTML tag:

for example adding in the assert_select for a title on a certain page:
```ruby
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end
  ```

and if there is no ```<title>``` in your static page (view), you will have a failing test

SIDENOTE: ERB is the primary template system for including dynamic content in web pages


In an effort to continue refactoring we are modifying the home static page:
```ruby
<% provide(:title, "Home") %>
<!DOCTYPE html>
<html>
  <head>
    <title><%= yield(:title) %> | Ruby on Rails Tutorial Sample App</title>
  </head>
  <body>
    <h1>Sample App</h1>
    <p>
      This is the home page for the
      <a href="https://www.railstutorial.org/">Ruby on Rails Tutorial</a>
      sample application.
    </p>
  </body>
</html>
```

using ```<% ... %>``` means Rails should call the provide function & associate the string "Home" with the label :title [this executes the code]

```<%= ... %>``` is used to insert the title into the template using Ruby's yield function [this executes and inserts the results into the template]

In the app/views/layouts/application.html.erb we have ```<%= yield %>``` now in the title element and in body - so this code is responsible to inserting contents of each page into the layout

***

**Built in Helpers**

```ruby
<%= stylesheet_link_tag 'application', media: 'all',
                                       'data-turbolinks-track': 'reload' %>
```

This line uses the built-in Rails function ```stylesheet_link_tag``` to include ```application.css``` for all media types

Rails allows for the creation of new custom functions/helpers

***

**Strings**

```ruby
>> ""         # string literal
=> ""
>> "foo" + "bar"    # String concatenation
=> "foobar"
>> first_name = "Michael"    # Variable assignment
=> "Michael"
>> "#{first_name} Hartl"     # String interpolation
=> "Michael Hartl"
>> last_name = "Hartl"
=> "Hartl"
>> first_name + " " + last_name    # Concatenation, with a space in between
=> "Michael Hartl"
>> "#{first_name} #{last_name}"    # The equivalent interpolation
=> "Michael Hartl"

>> 'foo'          # A single-quoted string
=> "foo"
>> 'foo' + 'bar'
=> "foobar"
>> '#{foo} bar'     # Single-quoted strings don't allow interpolation
=> "\#{foo} bar"  # console returns double quoted strings anyway

# if you need to include a backslash (which is normally a special character), using single quotes makes that easier

>> '\n'       # A literal 'backslash n' combination
=> "\\n"
```

***

**Objects**

Everything in Ruby is an object - even ```nil```

So it's easier to describe what objects *do*, which is respond to messages/methods

For examples:
```ruby
>> "foobar".length        # Passing the "length" message to a string
=> 6
>> "foobar".empty? # ? indicates return value is boolean
=> false
>> "".empty?
=> true
```