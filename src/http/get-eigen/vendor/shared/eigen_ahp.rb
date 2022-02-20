require_relative "./eigen"
class EigenAhp
  def initialize(matrix:, precision: 2)
    @matrix = matrix
    @precision = precision
  end

  def call
    eigenpairs = Eigen.new(matrix: @matrix).call

    eigenpairs.select do |eival, eivec|
      eivec.all?(&:positive?) || eivec.all?(&:negative?)
    end.map do |eival, eivec|
      vecvals = eivec.to_a.map do |n|
        n.abs.round(@precision)
      end
      denom = vecvals.sum

      [
        eival.round(@precision),
        vecvals.map do |n|
          (n.to_f / denom).round(@precision)
        end,
      ]
    end.sort_by(&:first)
  end
end
