require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  let(:user) { create(:user)}
  let!(:categories) { create_list(:category, 10) }
  let(:category_id) { categories.first.id}
  let(:headers) { valid_headers }

  describe 'GET /categories' do

    before { get '/categories', params: {}, headers: headers }

    #it "returns categories" do
      #expect(json).not_to be_empty
      #expect(json.size).to eq(10)
    #end

    #it "returns status code 200" do
    #  expect(response).to have_http_status(200)
  #  end
end

  describe 'GET /categories/:id' do

    before { get "/categories/#{category_id}", params: {}, headers: headers }

    context 'when the record exists' do

      it "returns the category" do
        expect(json).not_to be_empty
        #expect(json['id']).to eq(category_id)
      end

      #it "returns status code 200" do
        #expect(response).to have_http_status(200)
      #end
    end

    context 'when the record does not exist' do
      let(:category_id) {100}

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  describe 'POST /categories' do
    let(:valid_attributes) do
        { name: 'Homework' }.to_json

    context 'when the request is valid' do
      before { post '/categories', params: valid_attributes, headers: headers}

      it "creates a category" do
        expect(json['name']).to eq('Homework')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) {{ name: nil}.to_json}
      before { post '/categories', params: invalid_attributes, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /categories/:id' do
    let(:valid_attributes) { {name: 'Health'}.to_json}

    context 'when the record exists' do
      before { put "/categories/#{category_id}", params: valid_attributes, headers: headers}

      it "updates the record" do
        expect(response.body).not_to be_empty
      end

      #it "returns status code 204" do
        #expect(response).to have_http_status(204)
    #  end
    end
  end

  describe 'DELETE /categories/:id' do
    before { delete "/categories/#{category_id}", params: {}, headers: headers}

    #it "returns status code 204" do
      #e#xpect(response).to have_http_status(204)
    #end
  end
end
end
