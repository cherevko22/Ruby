class Flyer
  attr_accessor :name, :email, :miles_flown, :flyers

  def initialize(name, email, miles_flown)
    @name = name
    @email = email
    @miles_flown = miles_flown

  end

  def to_s
    "#{name} (#{email}): #{miles_flown}"
  end

end

flyers = []

-2.upto(5) do |x|
  flyers << Flyer.new("Flyer #{x}", "flyer#{x}@example.com", "#{x}000")
end

puts flyers
