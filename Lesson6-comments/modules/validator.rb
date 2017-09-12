module Validator
  def valide?
    validate!
  rescue
    false
  end
end
