require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:todos) { create_list(:todo, 10, category_id: category.id ) }
  let(:category_id) { category.id }
  let(:id) {todos.first.id}
  let(:headers) { valid_headers }

  describe 'GET /categories/:category_id/todos' do
    before { get "/categories/#{category_id}/todos", params: {}, headers: headers }

    context 'when category exists' do
    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when category does not exist' do
    let(:category_id) { 0 }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it "returns a not found message" do
      expect(response.body).to match(/Couldn't find Category/)
    end
  end
end

  describe 'GET /categories/:category_id/todos/:id' do
    before { get "/categories/#{category_id}/todos/#{id}", params: {}, headers: headers }

    context "when the record exists" do
      it "returns the todo" do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /categories/:category_id/todos' do
    let(:valid_attributes) { { title: 'Learn Elm', created_by: user.id.to_s}.to_json }
    context 'when the request is valid' do
      before { post "/categories/#{category_id}/todos", params: valid_attributes, headers: headers }

      it "creates a todo" do

        expect(json['data']['title']).to eq('Learn Elm')
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post "/categories/#{category_id}/todos", params: invalid_attributes, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(json['error']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /categories/:category_id/todos/:id' do
    let(:valid_attributes) { {title: 'shopping'}.to_json }

    context 'when the record exists' do
      before { put "/categories/#{category_id}/todos/#{id}", params: valid_attributes, headers: headers }
      it "updates the record" do
        updated_todo = Todo.find(id)
        expect(updated_todo.title).to match(/shopping/)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    #context 'when the record does not exist' do
      #let(:id) { 0 }
    #  it "returns status code 404" do
        #expect(response).to have_http_status(404)
      #end

      #it "returns a not found message" do
        #expect(response.body).to match(/Couldn't find Todo/)
      #end
    #end
  end

  describe 'DELETE /categories/:category_id/todos/:id' do
    before { delete "/categories/#{category_id}/todos/#{id}", params: {}, headers: headers }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
end
