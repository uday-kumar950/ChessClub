require "rails_helper"
describe MembersController, :type => :controller do

    describe "new" do
      it "exposes a new member" do
        get :new

        assigns(:member).should_not be_nil
      end
    end


    describe "create" do
      context "with valid params" do
        it "creates a member" do
          member_attributes = FactoryGirl.attributes_for(:member)
          post :create, params: {member: member_attributes}

          Member.first.should_not be_nil
        end
      end

      context "with invalid params" do
        it "renders new if invalid params" do
          post :create, params: {member: {name: nil}}

          response.should render_template(:new)
        end
      end
  end

   describe "show" do
    it "shows the member" do
      member = FactoryGirl.create(:member)

      get :show, params: {id: member}

      assigns(:member).should == member
    end
  end


  describe "update" do
    context "with valid params" do
      it "redirects to the member's show page" do
        member = FactoryGirl.create(:member, first_name: "First player")

        put :update, params: {id: member, member: {first_name: "Second Player"}}

        response.should redirect_to(member_path(member))
      end
    end

    context "with invalid params" do
      it "renders the edit page" do
        member = FactoryGirl.create(:member, first_name: "First player")

        put :update, params: {id: member, member: {first_name: nil}}

        response.should render_template(:edit)
      end
    end
  end
end
