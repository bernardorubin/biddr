require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  describe '#create' do
    context 'without a signed in user' do
      it 'redirects to the sign in page' do
        auction = create(:auction)
        # WHY DO I HAVE TO PASS AUCTION_ID?
        post :create, params: {auction_id: auction}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with a signed in user' do
      login_user
      context 'with valid attributes' do
        it 'create a new bid in the database' do
          count_before = Bid.count
  #  Validation failed: Email has already been taken
          # auction = create(:auction)
          # bid = create(:bid)
          post :create#, params: { auction_id: auction }
  #  No route matches {:action=>"create", :controller=>"bids"}
          count_after = Bid.count
          expect(count_after).to eq(count_before + 1)
        end

        # it "redirects to the bid path" do
        #   post :create, params: { bid: attributes_for(:bid) }
        #   expect(response).to redirect_to(bid_path(Bid.last))
        # end
        #
        # it 'associates the created bid with the signed in user' do
        #   post :create, params: { bid: attributes_for(:bid) }
        #   expect(Bid.last.user).to eq(@user)
        # end
      end
    end
    # context 'with invalid attributes' do
    #   login_user
    #   it 'doesn\'t create an bid in the database' do
    #     count_before = Bid.count
    #     # post :create, params: { bid: {bid: "" }
    #     # count_after = Bid.count
    #     expect(count_after).to eq(count_before)
    #   end
    #   it 'renders the new template' do
    #     post :create, params: { bid: {bid: "" } }
    #     expect(response).to render_template('auctions/show')
    #   end
    # end





  # describe '#destroy' do
  #   context 'with no signed in user' do
  #     it 'redirects the user to the sign in page' do
  #       product = create(:product)
  #       delete :destroy, params: { id: product.id }
  #       expect(response).to redirect_to(new_session_path)
  #     end
  #   end
  #
  #   context 'with owner of product signed in' do
  #     before { request.session[:user_id] = user.id }
  #
  #     it 'removes the record from the database' do
  #       product = create(:product, user: user)
  #       count_before = Product.count
  #       delete :destroy, params: { id: product.id }
  #       count_after = Product.count
  #       expect(count_before).to eq(count_after + 1)
  #     end
  #   end
  #
  #   context 'with the non-owner of the product signed in' do
  #     before { request.session[:user_id] = user.id }
  #
  #     it 'redirects to root path' do
  #       product = create(:product)
  #       delete :destroy, params: { id: product.id }
  #       expect(response).to redirect_to(root_path)
  #     end
  #   end



  end



end
