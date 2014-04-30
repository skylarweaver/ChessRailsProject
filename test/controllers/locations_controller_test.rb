require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    @location = locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, location: { active: @location.active, city: @location.city, latitude: @location.latitude, longitude: @location.longitude, max_capacity: @location.max_capacity, name: @location.name, state: @location.state, street_1: @location.street_1, street_2: @location.street_2, zip: @location.zip }
    end

    assert_redirected_to location_path(assigns(:location))
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location
    assert_response :success
  end

  test "should update location" do
    patch :update, id: @location, location: { active: @location.active, city: @location.city, latitude: @location.latitude, longitude: @location.longitude, max_capacity: @location.max_capacity, name: @location.name, state: @location.state, street_1: @location.street_1, street_2: @location.street_2, zip: @location.zip }
    assert_redirected_to location_path(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to locations_path
  end
end
