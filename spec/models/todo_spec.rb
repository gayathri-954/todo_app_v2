require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "is valid with a title and description" do
    todo = Todo.new(title: "Buy groceries", description: "Get milk and bread")
    expect(todo).to be_valid
  end

  it "is not valid without a title" do
    todo = Todo.new(description: "No title here")
    expect(todo).to_not be_valid
  end
end
