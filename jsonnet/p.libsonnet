{
  _config:: {
    prefix: 'envdiff',
  },
  group:: {
    new(name, metrics=[]): self + { name: name },
  },
  rule:: {
    first:: {
      new(metric, label=''):: if label == ''
      then self.withRecord(metric).withExpr(metric)
      else self.withRecordLabel(metric, label).withExprLabel(metric, label),
      withRecord(metric):: std.join('::', [$._config.prefix, metric]),
      withRecordLabel(metric, label):: std.join('::', [$._config.prefix, metric, label]),
    },
    second:: {

    },
  },
}
