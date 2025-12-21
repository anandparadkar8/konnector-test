require "test_helper"

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get Courses" do
    get schools_Courses_url
    assert_response :success
  end

  test "should get Batches" do
    get schools_Batches_url
    assert_response :success
  end

  test "should get Students" do
    get schools_Students_url
    assert_response :success
  end

  test "should get EnrollmentRequests" do
    get schools_EnrollmentRequests_url
    assert_response :success
  end
end
