require "duck_chain/version"
require "duck_chain/toolset"
require "duck_chain/active_record_extensions"

ActiveRecord::Base.extend DuckChain::ActiveRecordExtensions

ActiveRecord::Base.subclasses.select{|m|
  res=false
  begin
    res= true if m.column_names.class == Array
  rescue Exception => e
    res= false #doesn't actually have columns
  end
  res
}.each{|model|
  cols = model.column_names.map(&:to_sym)
  model.send(:duck_chain,*cols)
  # code = "class #{model.name} < ActiveRecord::Base \n"
  # code += "duck_chain #{cols.join(",:").insert(0,":")} \n"
  # code += "end"
  # eval(code)
}