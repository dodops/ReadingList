require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:book) { create(:book) }
  let(:valid_attributes) { attributes_for(:book) }
  let(:invalid_attributes) { attributes_for(:book, title: nil) }

  describe "GET #index" do

    it "assigns all books as @books" do
      get :index, {}
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #show" do

    context "when the user is logged" do
      login_user

      it "assigns the requested book as @book" do
        get :show, {:id => book.to_param}
        expect(assigns(:book)).to eq(book)
      end

    end
  end

  describe "GET #new" do
    login_user

    it "assigns a new book as @book" do
      get :new, {}
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe "GET #edit" do

    it "assigns the requested book as @book" do
      get :edit, {:id => book.to_param}
      expect(assigns(:book)).to eq(book)
    end
  end

  describe "POST #create" do

    context "with valid user" do
      login_user

      it "creates a new Book" do
        expect {
          post :create, {:book => valid_attributes}
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
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
    let(:new_attributes) { attributes_for(:book, title: 'new one') }

    context "with valid params and user signed" do
      login_user

      it "updates the requested book" do
        put :update, {:id => book.to_param, :book => new_attributes}
        book.reload
        expect(book.title).to eq(new_attributes[:title])
      end

      it "assigns the requested book as @book" do
        put :update, {:id => book.to_param, :book => valid_attributes}
        expect(assigns(:book)).to eq(book)
      end
    end

    context "with invalid user" do

      it "should not update the page" do
        put :update, {:id => book.to_param, :book => new_attributes}
        expect(response).to_not be_success
      end
    end

  end

  describe "DELETE #destroy" do

    context 'with a valid user' do
      login_user

      it "destroys the requested book" do
        book = Book.create! valid_attributes
        expect {
          delete :destroy, {:id => book.to_param}
        }.to change(Book, :count).by(-1)
      end

      it "redirects to the books list" do
        book = Book.create! valid_attributes
        delete :destroy, {:id => book.to_param}
        expect(response).to redirect_to(books_url)
      end
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
