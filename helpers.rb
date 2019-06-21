def require_all(f)
  Dir.glob("#{File.dirname(f)}/*.rb").each do |file|
    require file unless file == f
  end
end
