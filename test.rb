load 'lib.rb'

Dir.glob("lib/*.spec.rb").each do |f|
  load f
end

TestRunner.run
