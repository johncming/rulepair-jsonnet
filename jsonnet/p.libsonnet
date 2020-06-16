{
  _config:: {
    prefix: 'envdiff',
  },
  group:: {
    new(name, metrics=[]): self + { name: name },
  },
  rule:: {
    new(metric, label=''):: self.withFirst(metric, label).withSecond(metric, label),
    withFirst(metric, label):: self + self.mixin.first.new(metric, label),
    withSecond(metric, label):: self + self.mixin.second.new(metric, label),
    mixin:: {
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
        new(metric, label=''):: self.withRecord(metric) + if label == ''
        then self.withExpr(metric)
        else self.withExprLabel(metric, label),
        withRecord(metric):: '%(metric)s::result' % { metric: metric },
        withExpr(metric):: '%(metric)s{env:%(env1)s} == bool ignoring (env) {%(metric)s{env:%(env2)s}' % { metric: metric, env1: $._config.env.left, env2: $._config.env.right },
      },
    },
  },
}
