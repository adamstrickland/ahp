require "matrix"
require "matrix/eigenvalue_decomposition"

class Eigen
  def initialize(matrix:)
    val = ->(x) { x.respond_to?(:each) }
    raise unless val.call(matrix)
    raise unless matrix.all?{ |r| val.call(r) }

    widths = matrix.map(&:size)

    raise unless widths.uniq.count == 1

    width = widths.first
    height = matrix.size

    raise unless width == height

    @matrix = matrix
  end

  def call
    decomp.eigenvalues.zip(decomp.eigenvectors).select do |_, eivec|
      eivec.all?(&:real?)
    end
  end

  private

  def decomp
    matrix = Matrix[*@matrix]
    @decomp ||= Matrix::EigenvalueDecomposition.new(matrix)
  end
end
