require 'test_helper'

class RoutesTest < ActionController::IntegrationTest
  test 'root route' do
    assert_generates '/', {:controller => 'static', :action => 'home'}
  end

  test 'user routes' do
    assert_generates '/users', {:controller => 'users', :action => 'index'}
    assert_generates '/users', {:controller => 'users', :action => 'create'}
    assert_generates '/users/1', {:controller => 'users', :action => 'show', :id => 1}
  end

  test 'registration route' do
    assert_generates '/register', {:controller => 'users', :action => 'new'}
  end

  test 'session routes' do
    assert_generates '/login', {:controller => 'sessions', :action => 'create'}
    assert_generates '/logout', {:controller => 'sessions', :action => 'destroy'}
  end

  test 'app routes' do
    assert_generates '/apps', {:controller => 'apps', :action => 'index'}
    assert_generates '/apps/1', {:controller => 'apps', :action => 'show', :id => 1}
    assert_generates '/apps/1/flag', {:controller => 'apps', :action => 'flag', :id => 1} # RESTful?
  end

  # TODO make a resource controller+model?
  test 'other static routes' do
    assert_generates '/search', {:controller => 'static', :action => 'search'}
    assert_generates '/about', {:controller => 'static', :action => 'about'}
  end
end
