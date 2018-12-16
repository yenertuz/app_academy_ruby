require "rspec"
require "tdd"

describe Array do

	describe ".my_uniq" do 

		subject { [1, 1, 2, 2, 3]  }

		it "removes dupes" do 
			expect(subject.my_uniq).to eq([1, 2, 3])
		end
	end

	describe ".two_sum" do
		it "finds all pairs of positions where elements at those positions sum to zero" do 
			expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
		end
	end

	describe "my_transpose()" do 
		subject {  [[0, 1, 2], [3, 4, 5], [6, 7, 8]]          }

		it "converts between the row oriented and column oriented representations of an array" do 
			expect(my_transpose(subject)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
		end

		it "raises error when argumetn is not an array" do 
			expect{ my_transpose("test")}.to raise_error(ArgumentError, "Argument not an array")
		end
	end

	describe "stock picker" do
		subject {  [[1, 2], [3, 4], [5, 6]]    }

		it "returns an array (of 2 elements) with the number (not index, but index + 1) of day to buy and sell" do
			expect(stock_picker(subject)).to eq([0, 2])
		end
	end

end

describe Toh do

	subject {  Toh.new  }

	describe "#move" do

		it "moves when valid" do 
			expect(subject.move(1, 2)).to eq(true)
		end

		it "does not move when invalid" do 
			expect(subject.move(0, 2)).to eq(false)
		end

	end

	describe "#end?" do

		it "return false when game is not over" do 
			expect(subject.end?).to eq(false)
		end

	end
end