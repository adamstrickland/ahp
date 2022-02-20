require "json"
require "./vendor/shared/eigen_ahp"

def handler(event:, context:)
  data = event["queryStringParameters"]["m"]

  raise if data.nil?

  score = EigenAhp.new(matrix: JSON.parse(data)).call&.first&.last

  raise if score.nil?

  score.join("\n")
end

