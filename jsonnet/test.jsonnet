local p = import 'p.libsonnet';

{
  local r1 = p.rule.new('up'),
  local r2 = p.rule.new('down'),
  groups: p.group.new('test').addRules([r1, r2]),
}
