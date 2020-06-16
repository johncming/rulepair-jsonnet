{
  _config:: {
    prefix: 'envdiff',
  },
  group:: {
    new(name, metrics=[]): self + { name: name },
  },
}
