require 'spec_helper'

describe DarkswarmController do
  render_views
  let(:distributor) { create(:distributor_enterprise) }

  before do
    controller.stub(:load_data_for_sidebar).and_return nil
    Enterprise.stub(:distributors_with_active_order_cycles).and_return [distributor]
    Enterprise.stub(:is_distributor).and_return [distributor]
  end
  it "sets active distributors" do
    get :index
    assigns[:active_distributors].should == [distributor]
  end
  
  # This is done inside RABL template
  it "gets the next order cycle for each hub" do
    OrderCycle.stub_chain(:with_distributor, :soonest_closing, :first)
    OrderCycle.should_receive(:with_distributor).with(distributor)
    get :index
  end
end

