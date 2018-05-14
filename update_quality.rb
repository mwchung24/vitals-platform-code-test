require 'award'

def update_quality(awards)
  awards.each do |award|
    # Blue Distinction Plus has a quality of 80 and quality is never altered
    if award.name != 'Blue Distinction Plus'
      if award.name == 'Blue Compare'
        blue_compare(award)
      elsif award.name == 'Blue First'
        blue_first(award)
      elsif award.name == 'Blue Star' && award.quality > 0
        blue_star(award)
      else
        normal(award)
      end
      award.expires_in -= 1
    end
  end
end

def normal(award)
  # Normal Items lose quality the older they get and quality can never be negative
  award.quality -= 1 if award.quality > 0
  if award.expires_in <= 0
    # Once the expiration date is 0 or less, the quality decreases twice as fast
    award.quality -= 1 if award.quality > 0
  end
end

def blue_star(award)
  # Blue Stars lose quality value twice as fast as normal awards and quality can never be negative
  award.quality -= 2 if award.quality >= 2
  # Once the expiration date is 0 or less, the quality decreases twice as fast
  if award.expires_in <= 0
    award.quality -= 2 if award.quality >= 2
  end

end

def blue_first(award)
  # Blue First's quality cannot be over 50
  if award.quality < 50
    # Blue First quality increases the older they get
    award.quality += 1
    # Once the expiration date is 0 or less, the quality increases twice as fast
    if award.expires_in <= 0 && award.quality < 50
      award.quality += 1
    end
  end
end

def blue_compare(award)
  # Blue Compare's quality cannot be over 50
  # if the expiration date is between 6-10 days, award quality increases by 2
  if award.expires_in < 11 && award.expires_in > 5
    # just a check to make sure the quality is not 49.. adding two would put it over 50
    if award.quality < 49
      award.quality += 2
    else
      award.quality = 50
    end
  # if the expiration date is 5 days or less, award quality increases by 3
  elsif award.expires_in < 6
    # just a check to make sure the quality is not 48.. adding three would put it over 50
    if award.quality < 48
      award.quality += 3
    else
      award.quality = 50
    end
    # otherwise the award quality just increases normally with 1
  else
    award.quality += 1
  end

  # if the quality of the Blue Compare drops to 0 if the expiration date is 0 or less
  if award.expires_in <= 0
    award.quality = 0
  end
end
