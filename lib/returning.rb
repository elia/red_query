def returning(x, &block)
  block.call(x)
  return x
end
