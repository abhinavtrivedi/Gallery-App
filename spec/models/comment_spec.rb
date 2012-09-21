require 'spec_helper'

describe Comment do
  let(:comment) {Comment.new(comment_text: 'Test comment')}

  subject{comment}

  it {should respond_to :comment_text}
  it {should respond_to :user}
  it {should respond_to :artifact}
  it {should be_valid}

  describe "when comment text is empty" do
    before {comment.comment_text = nil}

    it {should_not be_valid}
  end

end
