require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", :bake => 21, :titleize => "Yener") }
  subject { Dessert.new("type", 40, chef)  }

  describe "#initialize" do
	it "sets a type" do
		expect(subject.type).to eq("type")
	end

	it "sets a quantity" do
		expect(subject.quantity).to eq(40)
	end

	it "starts ingredients as an empty array" do 
		expect(subject.ingredients).to eq([])
	end

	it "raises an argument error when given a non-integer quantity" do
		expect {Dessert.new("type2", "ss", "yener")}.to raise_error(ArgumentError)
	end
  end

  describe "#add_ingredient" do
	it "adds an ingredient to the ingredients array" do 
		subject.add_ingredient("ingredient1")
		expect(subject.ingredients).to include("ingredient1") end
  end

  describe "#mix!" do
	it "shuffles the ingredient array" do
		(0..20).each { |n|   subject.add_ingredient(n)               }
		subject.mix!
		expect(subject.ingredients).to_not eq((0..20).to_a)
	end
  end

  describe "#eat" do
	it "subtracts an amount from the quantity" do 
		subject.eat(20)
		expect(subject.quantity).to eq(20)
	end

	it "raises an error if the amount is greater than the quantity" do 
		expect { subject.eat(200) }.to raise_error
	end
  end

  describe "#serve" do
	it "contains the titleized version of the chef's name" do 
		expect(subject.serve).to include("Yener") end 
  end

  describe "#make_more" do
	it "calls bake on the dessert's chef with the dessert passed in" do 
		expect(subject.make_more).to eq(21) 
	end
  end
end
