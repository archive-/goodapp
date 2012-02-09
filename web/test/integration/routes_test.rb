require 'test_helper'

class RoutesTest < ActionController::IntegrationTest
  test 'route test' do
    assert_generates '/', {:controller => 'static', :action => 'home'}
    assert_generates '/devs', {:controller => 'devs', :action => 'index'}
    assert_generates '/devs/729382179481724', {:controller => 'devs', :action => 'show'}
    assert_generates '/register', {:controller => 'devs', :action => 'new'}
    assert_generates '/login', {:controller => 'sessions', :action => 'create'}
    assert_generates '/logout', {:controller => 'sessions', :action => 'destroy'}
    assert_generates '/apps/729382179481724', {:controller => 'apps', :action => 'show'}
    assert_generates '/apps/729382179481724/flag', {:controller => 'apps', :action => 'flag'} # RESTful?
  end
end
