require 'test_helper'

class RoutesTest < ActionController::IntegrationTest
  test 'root route' do
    assert_generates '/', {:controller => 'static', :action => 'home'}
  end

  test 'dev routes' do
    assert_generates '/devs', {:controller => 'devs', :action => 'index'}
    assert_generates '/devs/1', {:controller => 'devs', :action => 'show', :id => 1}
  end

  test 'registration route' do
    assert_generates '/register', {:controller => 'devs', :action => 'new'}
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
end
