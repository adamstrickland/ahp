# require "bundler/setup"
require "json"
require "./vendor/shared/eigen_ahp"

def handler(event:, context:)
  params = event["queryStringParameters"]
  matrix_param = params["m"]
  precision = params.fetch("p", 2).to_i

  raise if matrix_param.nil?

  matrix_data = JSON.parse(matrix_param)

  EigenAhp.new(matrix: matrix_data, precision: precision).call.map do |eival, eivec|
    { eigenvalue: eival, eigenvector: eivec }
  end
end

