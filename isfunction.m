function out = isfunction(value)

  if isa(value, 'function handle')
    out = 1;
  else
    out = 0;
  end
  

end