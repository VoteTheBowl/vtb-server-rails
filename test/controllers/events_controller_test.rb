require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create event" do
    assert_difference("Event.count") do
      post "/api/vote/event/create", params: { "name": "A new Event!", "choices": [ "Apple", "Banana", "Egg" ], "electoral_system": "RC" }, as: :json
    end
    assert_response :success
  end

  test "should not show event" do
    get "/api/vote/event/#{events(:one).id}", as: :json
    assert_response 401
  end

  # test "should show event" do
  #   get "/api/vote/event/#{events(:two).id}", headers: { "X-API-Key": "test" }, as: :json
  # end
end
