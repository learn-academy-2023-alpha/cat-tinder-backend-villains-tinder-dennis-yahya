require 'rails_helper'

RSpec.describe "Villains", type: :request do
  describe "GET /index" do
    it "gets a list of villains" do 
      Villain.create(
      name: 'Joker',
      age: 34,
      enjoy: 'Messing with Batman',
      img: "https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg")

      # Make a request to the specific endpoint
      get '/villains'

      # We need our response to be in the format of JSON and then we assigned it to a variable
      villain = JSON.parse(response.body)
      # Check that the request has an http status of 200
      expect(response).to have_http_status(200)
      # Check that we are returning the accurate amount of data
      expect(villain.length).to eq 1
    end
  end

  describe "POST / create" do 
    it "creates a villain" do 
      villain_params = {
        villain: {
          name: 'Joker',
      age: 34,
      enjoy: 'Messing with Batman',
      img: "https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg"
        }
      }

      # Make a request to the server and pass params 
      post '/villains', params: villain_params 

      # Assure we have a successful response
      expect(response).to have_http_status(200)
      # Look up the villain we expect to be created in the database
      villain = Villain.last 
      # Assure the created villain has the correct attributes
      expect(villain.name).to eq 'Joker'
      expect(villain.age).to eq 34
      expect(villain.enjoy).to eq 'Messing with Batman'
      expect(villain.img).to eq "https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg"
    end

    it "doesn't create a villain without a name" do
      villain_params = {
        villain: {
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }
      # Send the request to the  server
      post '/villains', params: villain_params
      # expect an error if the villain_params does not have a name
      expect(response.status).to eq 422
      # Convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)
      # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
      expect(json['name']).to include "can't be blank"
    end
  
    it "doesn't create a villain without an age" do
      villain_params = {
        villain: {
          name: 'Joker',
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }
      # Send the request to the  server
      post '/villains', params: villain_params
      # expect an error if the villain_params does not have a name
      expect(response.status).to eq 422
      # Convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)
      # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
      expect(json['age']).to include "can't be blank"
    end
  
    it "doesn't create a villain without an enjoy" do
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }
      # Send the request to the  server
      post '/villains', params: villain_params
      # expect an error if the villain_params does not have a name
      expect(response.status).to eq 422
      # Convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)
      # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
      expect(json['enjoy']).to include "can't be blank"
    end
    
    it "doesn't create a villain without an img" do
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman'
        }
      }
      # Send the request to the  server
      post '/villains', params: villain_params
      # expect an error if the villain_params does not have a name
      expect(response.status).to eq 422
      # Convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)
      # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
      expect(json['img']).to include "can't be blank"
    end
  end

  describe "PATCH /update" do 
    it 'updates a villain' do 
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

      post '/villains', params: villain_params 
      villain = Villain.first

      updated_villain_params = {
        villain: {
          name: 'Joker',
          age: 50,
          enjoy: 'Causing havoc in Gotham',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

      patch "/villains/#{villain.id}", params: updated_villain_params

      # Create a variable to store the updated villain by finding the original villain created in this test
      updated_villain = Villain.find(villain.id)
      expect(response).to have_http_status(200)
      expect(updated_villain.age).to eq 50
    end

    it "doesn't update a villain if it is not valid" do
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

    post '/villains', params: villain_params 
      villain = Villain.first

      updated_villain_params = {
        villain: {
          name: '',
          age: 34,
          enjoy: 'Causing havoc in Gotham',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }
      patch "/villains/#{villain.id}", params: updated_villain_params

      # Create a variable to store the updated villain by finding the original villain created in this test
      updated_villain = Villain.find(villain.id)
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end

    it "doesn't update a villain if it is not valid" do
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

    post '/villains', params: villain_params 
      villain = Villain.first

      updated_villain_params = {
        villain: {
          name: 'Joker',
          age: nil,
          enjoy: 'Causing havoc in Gotham',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

      patch "/villains/#{villain.id}", params: updated_villain_params

      # Create a variable to store the updated villain by finding the original villain created in this test
      updated_villain = Villain.find(villain.id)
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['age']).to include "can't be blank"
    end

    it "doesn't update a villain if it is not valid" do
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

    post '/villains', params: villain_params 
      villain = Villain.first

      updated_villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: '',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

      patch "/villains/#{villain.id}", params: updated_villain_params

      # Create a variable to store the updated villain by finding the original villain created in this test
      updated_villain = Villain.find(villain.id)
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['enjoy']).to include "can't be blank"
    end

    it "doesn't update a villain if it is not valid" do
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }

    post '/villains', params: villain_params 
      villain = Villain.first

      updated_villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: ''
        }
      }

      patch "/villains/#{villain.id}", params: updated_villain_params

      # Create a variable to store the updated villain by finding the original villain created in this test
      updated_villain = Villain.find(villain.id)
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['img']).to include "can't be blank"
    end

  end

  describe "DELETE /destroy" do 
    it 'deletes a villain' do 
      villain_params = {
        villain: {
          name: 'Joker',
          age: 34,
          enjoy: 'Messing with Batman',
          img: 'https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg'
        }
      }
      post '/villains', params: villain_params 
      villain = Villain.first
      villains = Villain.all

      delete "/villains/#{villain.id}"
      expect(response).to have_http_status(200)
      expect(villains).to be_empty
    end
  end
end
