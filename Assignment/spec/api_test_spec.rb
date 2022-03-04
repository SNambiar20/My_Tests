require 'rspec'
require 'json'
require 'rest-client'
require_relative '../lib/testcases'

describe 'api_test' do
#let(:user_data) { { "email": "assignment.2022@reqres.in", "first_name": "S123", "last_name": "N123","avatar":"https://reqres.in/img/faces/1-image.jpg" } }
let(:user_data) { { "email": "assignment.2022@reqres.in", "password": "S123" } }


  context 'retrieving users_list index with valid data', smoke: true do

    it 'responds with HTTP status 200' do
     @response = RestClient.get("https://reqres.in/api/users")
      expect(@response.code).to eq(200)
    end

    it 'returns a list  of users' do
      @response = RestClient.get("https://reqres.in/api/users")
      @parsed_data = JSON.parse(@response.body)
      $data = @parsed_data['data']
      expect($data.count).to eq(6)
    end

    it 'returns expected attributes for the user_data ' do
      @response = RestClient.get("https://reqres.in/api/users/2")
      @parsed_data = JSON.parse(@response.body)
      $data = @parsed_data['data']
        expect($data.keys).to include("id", "email", "first_name", "last_name", "avatar")
    end
  end

  context 'retrieving a single user_show with valid data ', smoke: true do

    it 'responds with HTTP status 200' do
      @response = RestClient.get("https://reqres.in/api/users/2")
      expect(@response.code).to eq(200)
    end

    it 'returns a single user' do
       @response = RestClient.get("https://reqres.in/api/users/2")
      @parsed_data = JSON.parse(@response.body)
      $data = @parsed_data['data']
      expect($data['id']==2)
    end

    it 'returns user data with expected attributes' do
       @response = RestClient.get("https://reqres.in/api/users/2")
      @parsed_data = JSON.parse(@response.body)
      $data = @parsed_data['data']
        expect($data.keys).to include("id", "email", "first_name", "last_name", "avatar")
    end

    it 'returns user id corresponding to the user' do
      @response = RestClient.get("https://reqres.in/api/users/2")
      @parsed_data = JSON.parse(@response.body)
      $data = @parsed_data['data']
      $data.each do |d|
      id= $data['id]']
      expect(id==2)
      end
    end
  end

  context 'retrieving a user_show with invalid id ' do

    it 'responds with HTTP status 404' do
      begin
      @response = RestClient.get("https://reqres.in/api/users/23")
      rescue RestClient::ExceptionWithResponse => e
       puts(@response = e.response)
     end
    end
  end

  context 'creating a user' do
 # @response = RestClient.post "https://reqres.in/api/users/register", "#{user_data}", headers={ :content_type => 'application/json'}

    it 'responds with HTTP status 201 and expected attributes' do
      begin
      @response = RestClient.post "https://reqres.in/api/users/register", "#{user_data}", headers={ :content_type => 'application/json'}
      rescue RestClient::ExceptionWithResponse => e
       puts(@response = e.response)
     end
      expect(@response.code).to eq(201)
      expect(JSON.parse @response.body).to include_json(
        status: "created",
        id: /.*/
      )
    end
  end
end

