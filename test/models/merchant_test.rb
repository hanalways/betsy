require "test_helper"

describe Merchant do
  let(:merchant) { Merchant.new }

  it "must be valid" do
    skip
    value(merchant).must_be :valid?
  end
end
