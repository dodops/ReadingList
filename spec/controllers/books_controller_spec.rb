require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  let(:valid_attributes) {
    { title: "Pica",
    author: "Douglas C.",
    description: "A random description",
    rating: 5 }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }


  describe "GET #index" do
    it "assigns all books as @books" do
      book = Book.create! valid_attributes
      get :index, {}
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #show" do
    context "when the user is logged" do
      it "assigns the requested book as @book" do
        sign_in(user)
        book = Book.create! valid_attributes
        get :show, {:id => book.to_param}
        expect(assigns(:book)).to eq(book)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new book as @book" do
      sign_in(user)
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe "GET #edit" do
    it "assigns the requested book as @book" do
      sign_in(user)
      book = Book.create! valid_attributes
      get :edit, {:id => book.to_param}
      expect(assigns(:book)).to eq(book)
    end
  end

  describe "POST #create" do
    context "with valid user" do
      it "creates a new Book" do
        sign_in(user)
        expect {
          post :create, {:book => valid_attributes}
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        sign_in(user)
        post :create, {:book => valid_attributes}
        expect(assigns(:book)).to be_a(Book)
        expect(assigns(:book)).to be_persisted
      end
    end

    context "with invalid user" do
      it "should not render the page" do
        post :create, {:book => valid_attributes}
        expect(response).to_not be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: "Somenewtitle", author: 'kkkk', description: 'sdsdsdsd'}
      }

      it "updates the requested book" do
        sign_in(user)
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => new_attributes}
        book.reload
        expect(assigns(:book)).to eq(book)
      end

      it "assigns the requested book as @book" do
        sign_in(user)
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}
        expect(assigns(:book)).to eq(book)
      end
    end

    context "with invalid user" do
      it "should not update the page" do
        new_attributes = {title: "Somenewtitle", author: 'kkkk', description: 'sdsdsdsd'}
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => new_attributes}
        expect(response).to_not be_success
      end
    end

  end

  describe "DELETE #destroy" do
    it "destroys the requested book" do
      sign_in(user)
      book = Book.create! valid_attributes
      expect {
        delete :destroy, {:id => book.to_param}
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      sign_in(user)
      book = Book.create! valid_attributes
      delete :destroy, {:id => book.to_param}
      expect(response).to redirect_to(books_url)
    end

    context "with invalid user" do
      it "should not delete the page" do
        book = Book.create! valid_attributes
        delete :update, {:id => book.to_param }
        expect(response).to_not be_success
      end
    end
  end

end
