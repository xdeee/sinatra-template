# frozen_string_literal: true

def require_all(rubyfile)
  Dir.glob("#{File.dirname(rubyfile)}/*.rb").each do |file|
    require file unless file == rubyfile
  end
end
