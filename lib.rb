def load_lib
  Dir.glob("lib/*.rb").delete_if { |s| s.include? ".spec." }.each do |f|
    load f
  end
end

def refresh
  load_lib
end

load_lib

