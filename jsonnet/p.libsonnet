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
      withRecord(metric):: { record: std.join('::', [$._config.prefix, metric]) },
      withRecordLabel(metric, label):: { record: std.join('::', [$._config.prefix, metric, label]) },
      withExpr(metric):: 'sum(%(metric)s) by (env)' % { metric: metric },
      withExprLabel(metric, label):: 'sum(%(metric)s) by (%(label)s, env)' % { metric: metric, label: label },
    },
    second:: {

    },
  },
}
