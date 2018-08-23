require 'test_helper'

class CaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
      @case1 = cases(:one)
      @case2 = cases(:two)
  end

  test "caseships test" do
      @case1.father(@case2)
      assert @case2.sub_cases.include?(@case1)

  end

end
