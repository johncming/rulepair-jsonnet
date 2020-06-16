local prom = import 'p.libsonnet';

{
  rule_without_label: prom.rule.new('up'),
  rule_with_label: prom.rule.new('up', 'host'),
}
