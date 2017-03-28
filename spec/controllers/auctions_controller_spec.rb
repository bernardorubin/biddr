require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  describe '#new' do
    context 'with no session' do
      it 'redirect to new session' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with session' do
      login_user
      it 'renders new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns an auction instance variable to a new Auction' do
        get :new
        expect(assigns(:auction)).to be_a_new Auction
      end

   end
  end

  describe '#create' do
    context 'without a signed in user' do
      it 'redirects to the sign in page' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with a signed in user' do
      login_user
      context 'with valid attributes' do
        it 'create a new auction in the database' do
          count_before = Auction.count
          post :create, params: { auction: attributes_for(:auction) }
          count_after = Auction.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the auction path" do
          post :create, params: { auction: attributes_for(:auction) }
          expect(response).to redirect_to(auction_path(Auction.last))
        end

        it 'associates the created auction with the signed in user' do
          post :create, params: { auction: attributes_for(:auction) }
          expect(Auction.last.user).to eq(@user)
        end
      end
    end
    context 'with invalid attributes' do
      login_user
      it 'doesn\'t create an auction in the database' do
        count_before = Auction.count
        post :create, params: { auction: {title: "", endson:""} }
        count_after = Auction.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        post :create, params: { auction: {title: "", endson:""} }
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    context 'without a signed in user' do
      it 'redirects to the sign in page' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'with a signed in user' do
      login_user
      it "redirects to the auction show path" do
        post :create, params: { auction: attributes_for(:auction) }
        # post :create, params: { auction: attributes_for(:auction) }
        get :show, params: {id: Auction.last.id}
        expect(response).to render_template (:show)
      end
    end
  end

  describe '#index' do
    context 'without a signed in user' do
      it 'redirects to the sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with a signed in user' do
      login_user
      it "redirects to the auction index path" do
        # post :create, params: { auction: attributes_for(:auction) }
        get :index
        expect(response).to render_template (:index)
      end
    end
  end

end
