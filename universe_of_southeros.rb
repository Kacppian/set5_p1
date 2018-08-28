# Assumptions -
# 1. If two kingdoms have equal number of allies, then nobody gets to rule

class UniverseOfSoutheros
  attr_accessor :ruler_name, :kingdoms, :allies_required, :ruling_kingdom

  def initialize(kingdoms: {}, allies_required: 3, ruling_kingdom: nil)
    @ruling_kingdom = ruling_kingdom
    @kingdoms = kingdoms
    @allies_required = allies_required
  end

  def kingdoms_eligible_to_rule
    kingdoms.select {|name, instance| instance.allies_list.length >= allies_required}
  end

  def update_ruling_kingdom
    eligible_kingdoms = eligible_to_rule
    if eligible_kingdoms.keys.length == 1
      ruling_kingdom = eligible_kingdoms.values.first
    end
    ruling_kingdom
  end
end
